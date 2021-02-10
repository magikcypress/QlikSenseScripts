#!/bin/bash

# Define your tenant url
tenant="$(cat ../secret/tenant)";
# Define your API key
apiKey="$(cat ../secret/api-key)";
# Define filename
FILENAME="../files/France-Team-Ecoles-Normandie.csv"
# Define space
space="$(cat ../secret/space)";
# Define url
url="https://$tenant/api/v1/temp-contents/60158d80cc3c9d00012dc6c0"

# Download temp files
curl -si -X GET "$url" -H "Authorization: Bearer $apiKey"
