#!/bin/bash

# Define your tenant url
tenant="$(cat ../secret/tenant)";
# Define your API key
apiKey="$(cat ../secret/api-key)";
# Define space
space="$(cat ../secret/space)";

# Get Connection ID
connectionId=$(curl -s "https://$tenant/api/v1/data-connections" -H "Authorization: Bearer $apiKey" | jq '.data[]' | grep -2 "$space" | tail -1 | awk -F'"' '{print $4}');
#connectionId=$(curl "https://$tenant/api/v1/data-connections" -H "Authorization: Bearer $apiKey" | jq -r ".data[] | map(select(.qConnectStatement==\"$space\")) | .qID");

# Define url
url="https://$tenant/api/v1/qix-datafiles?connectionId=$connectionId"

# List files
result=$(curl -s "$url" -H "Authorization: Bearer $apiKey");
echo $result > ../secret/list-files;
echo $result | jq '.[]';
