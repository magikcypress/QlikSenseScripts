#!/bin/bash

# Define your tenant URL
tenant="$(cat ../secret/tenant)";
# Define your API key
apiKey="$(cat ../secret/api-key)";

# Define app id
appId='d8c34cec-b655-492e-a5b9-ae15356d03fb';

# Setting URL
url="https://$tenant/api/v1/apps/$appId";
urlE="https://$tenant/api/v1/apps/$appId/export";

# Get app name
nameApp="$(curl -s -X GET -# "$url" -H "Authorization: Bearer $apiKey" | jq -r '.attributes | .name')";
echo $nameApp;
# Replace name App space per Underscore
nameApp=`echo $nameApp | tr ' ' '_' `;

# Get temp location
export="$(curl -si -X POST "$urlE" -H "Authorization: Bearer $apiKey" | grep -oP 'location: \K.*' | tr -d \")";
urlD="https://$tenant$export";
echo $urlD;

sleep 3;
# Download temp files
curl -s -X GET "$urlD" -o "$nameApp.qvf";
