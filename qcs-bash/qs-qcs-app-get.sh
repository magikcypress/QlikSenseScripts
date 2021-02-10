#!/bin/bash

# Define your tenant url
tenant="$(cat ../secret/tenant)";
# Define your API key
apiKey="$(cat ../secret/api-key)";
# Define appId
appId="$(cat ../secret/app-id)";
# Define url reload
url="https://$tenant/api/v1/apps/$appId";

# Get app
app="$(curl -s -X GET "$url" -H "Authorization: Bearer $apiKey")";
echo $app
