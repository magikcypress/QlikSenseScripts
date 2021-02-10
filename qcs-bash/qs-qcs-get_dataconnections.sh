#!/bin/bash

# Define your tenant url
tenant="$(cat ../secret/tenant)";
# Define your API key
apiKey="$(cat ../secret/api-key)";
# Define space
space="$(cat ../secret/space)";
# Define url
url="https://$tenant/api/v1/data-connections";

# Get Connection ID
curl -s "$url" -H "Authorization: Bearer $apiKey" | jq '.data[]' | grep -2 "$space" | tail -1 | awk -F'"' '{print $4}'
