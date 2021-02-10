#!/bin/sh

# Define your tenant url
tenant="$(cat ../secret/tenant)";
# Define your API key
apiKey="$(cat ../secret/api-key)";
# Define url
url="https://$tenant/api/v1/temp-contents/60158d80cc3c9d00012dc6c0/details"

# Download temp files
curl -si -X GET "$url" -H "Authorization: Bearer $apiKey"
