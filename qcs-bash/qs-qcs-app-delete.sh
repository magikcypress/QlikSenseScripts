#!/bin/bash

# Define your tenant url
tenant="$(cat ../secret/tenant)";
# Define your API key
apiKey="$(cat ../secret/api-key)";
# Define appId
appId="$(cat ../secret/app-id)";
# Define url delete
urlDelete="https://$tenant/api/v1/apps/$appId";

# Delete app
delete="$(curl -s -X DELETE -# "$urlDelete" -H "Authorization: Bearer $apiKey")";
echo $delete

removeAppId=$(> ../secret/app-id);
