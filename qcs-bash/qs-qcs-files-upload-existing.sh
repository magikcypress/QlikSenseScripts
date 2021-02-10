#!/bin/bash

# Define your tenant url
tenant="$(cat ../secret/tenant)";
# Define your API key
apiKey="$(cat ../secret/api-key)";
# Define filename
filename='files/France-Team-Ecolesi-Caen.csv';
# Define space
space="$(cat ../secret/space)";

# Get Connection ID
connectionId=$(curl "https://$tenant/api/v1/data-connections" -H "Authorization: Bearer $apiKey" | jq '.data[]' | grep -2 "$space" | tail -1 | awk -F'"' '{print $4}');

# Get Files
sourceId=$(curl "https://$tenant/api/v1/qix-datafiles?connectionId=$connectionId" -H "Authorization: Bearer $apiKey" | jq '.[]' | grep -1 "France" | head -1 | awk -F'"' '{print $4}'); 

# Define url
url="https://$tenant/api/v1/qix-datafiles?connectionId=$connectionId&name=$filename&SourceId=$sourceId"

# Upload files
upload="$(curl -v -i -X POST -# "$url" -H "Content-Type: application/octet-stream" --data-binary @- -H "Authorization: Bearer $apiKey")";
echo $upload
