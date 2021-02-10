#!/bin/bash

# Define your tenant url
tenant="$(cat ../secret/tenant)";
# Define your API key
apiKey="$(cat ../secret/api-key)";

# Define url
url="https://$tenant/api/v1/qix-datafiles/quota"

# Get quota
maxSize=$(curl -s -X GET "$url" -H "Authorization: Bearer $apiKey" | jq -r '.maxSize');
size=$(curl -s -X GET "$url" -H "Authorization: Bearer $apiKey" | jq -r '.size');
echo $(($maxSize/1024/1024/1024)) "GBs in quota"
echo $(($size/1024/1024/1024)) "GB used"
echo $(($size/$maxSize*100)) "% of quota remaining"
