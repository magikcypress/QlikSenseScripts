#!/bin/bash

# Define your tenant url
tenant="$(cat ../secret/tenant)";
# Define your API key
apiKey="$(cat ../secret/api-key)";
# Define url's
url="https://$tenant/api/v1/temp-contents/60158d80cc3c9d00012dc6c0"
urlL="https://$tenant/api/v1/temp-contents/files"

# List files
curl -si -X OPTIONS "$urlL" -H "Authorization: Bearer $apiKey"

