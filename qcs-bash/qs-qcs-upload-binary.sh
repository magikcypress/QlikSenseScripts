#!/bin/bash

## Stanger things script
### return error 400 (application/problem+json)

tenant="$(cat ../secret/tenant)";
apiKey="$(cat ../secret/api-key)";
filename='../files/France-Team-Ecoles-Caen.csv';
space="$(cat ../secret/space)";

# Get Connection ID
connectionId=$(curl "https://$tenant/api/v1/data-connections" -H "Authorization: Bearer $apiKey" | jq '.data[]' | grep -2 "$space" | tail -1 | awk -F'"' '{print $4}');

# Get Files
sourceId=$(curl "https://$tenant/api/v1/qix-datafiles?connectionId=$connectionId" -H "Authorization: Bearer $apiKey" | jq '.[]' | grep -1 "$space" | head -1 | awk -F'"' '{print $4}'); 

url="https://$tenant/api/v1/qix-datafiles?connectionId=$connectionId&name=$filename"

delim=$(cat /proc/sys/kernel/random/uuid);
lf="\r\n";
#mime="$(file -b --mime-type "$filename")";
readFile="$(cat $filename)";

# Create body
data() {
    printf %s "--$delim${lf}Content-Disposition: form-data; name=\"data\"; filename=\"${filename}\"${lf}"
    printf %s "Content-Type: application/octet-stream${lf}${lf}"
    printf %s "Data: ${readFile}"
    printf %s "${lf}--$delim--${lf}"
}


# Upload files
upload="$(data | curl -k -v -i -# "$url" -H "Accept: application/json" -H "Content-Type: multipart/form-data; boundary=--${delim}" --data @- -H "Authorization: Bearer $apiKey")";

