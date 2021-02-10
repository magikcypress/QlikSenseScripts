#!/bin/bash
# Define your tenant url
tenant="$(cat ../secret/tenant)";
# Define your API key
apiKey="$(cat ../secret/api-key)";
# Define filename
filename="../files/France-Team-Ecoles-Paris.csv";
# Define Space
space="$(cat ../secret/space)"

# Get Connection ID
connectionId=$(curl "https://$tenant/api/v1/data-connections" -H "Authorization: Bearer $apiKey" | jq '.data[]' | grep -2 "$space" | tail -1 | awk -F'"' '{print $4}');

# Get Files
sourceId=$(curl "https://$tenant/api/v1/qix-datafiles?connectionId=$connectionId" -H "Authorization: Bearer $apiKey" | jq '.[]' | grep -1 "$space" | head -1 | awk -F'"' '{print $4}'); 

# Define url
url="https://$tenant/api/v1/qix-datafiles?connectionId=$connectionId&name=$filename"

curl -k -X POST -# "$url" -H "Authorization: Bearer $apiKey" -H "content-type: multipart/form-data" -F data=@$filename
