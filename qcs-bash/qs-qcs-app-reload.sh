#!/bin/bash

# Define your tenant url
tenant="$(cat ../secret/tenant)";
# Define your API key
apiKey="$(cat ../secret/api-key)";
# Define appId
appId="$(cat ../secret/app-id)";
# Define url reload
urlReload="https://$tenant/api/v1/reloads";

# Reload app
reload="$(curl -s -X POST -# "$urlReload" -H "Content-type: application/json" -H "Authorization: Bearer $apiKey" -d '{"appId": "'"${appId}"'"}')";
echo $reload 
