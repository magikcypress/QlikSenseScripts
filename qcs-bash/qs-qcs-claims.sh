#!/bin/bash

# Define your tenant url
tenant="$(cat ../secret/tenant)";
# Define your API key
apiKey="$(cat ../secret/api-key)";
# Define url
url="https://$tenant/api/v1/diagnose-claims"

# Diagnose Claims
curl -s -X GET -# "$url" -H "Authorization: Bearer $apiKey" | jq -r '.[]'
