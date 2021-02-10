#!/bin/bash

# Define your tenant url
tenant="$(cat ../secret/tenant)";
# Define your API key
apiKey="$(cat ../secret/api-key)";
# Define filename
filename="../files/XTAQSjJ.jpg"
# Define url
url="https://$tenant/api/v1/temp-contents?ttl=259200&filename=$filename"

# List files
curl -si -X POST "$url" -H "Authorization: Bearer $apiKey" -H "Content-type: application/octet-stream" --data-binary "@$filename"

