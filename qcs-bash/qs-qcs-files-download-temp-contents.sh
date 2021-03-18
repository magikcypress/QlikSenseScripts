#!/bin/bash

# Define your tenant url
tenant="$(cat ../secret/tenant)";
# Define your API key
apiKey="$(cat ../secret/api-key)";
# Define url
url="https://$tenant/api/v1/temp-contents/605357d75ddea00001182029"

# Download temp files
curl -s -X GET "$url" -H "Authorization: Bearer $apiKey" -o Ecoles-Francaise.qvf
