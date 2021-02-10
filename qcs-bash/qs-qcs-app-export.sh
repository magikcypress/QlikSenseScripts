#!/bin/bash

# Define your tenant URL
tenant="$(cat ../secret/tenant)";
# Define your API key
apiKey="$(cat ../secret/api-key)";

# Define app id
AppId='d8c34cec-b655-492e-a5b9-ae15356d03fb';

# Setting URL
url="https://$tenant/api/v1/apps/$appId";
urlE="https://$tenant/api/v1/apps/$appId/export";
urlTmp="https://$tenant/api/v1/apps/temp-contents/601411722823140001ebc69c";

# Get app info
nameApp="$(curl -s -X GET -# "$url" -H "Authorization: Bearer $apiKey" | jq -r '.attributes | .name')";
echo $nameApp;

# Export file
export="$(curl -v -i -X POST -# "$urlE" -H "Authorization: Bearer $apiKey")";
echo $export.Headers.Location

#getTempContent="$(curl -v -i -# "$urlTmp" -H "Authorization: Bearer $apiKey")";
#echo $getTempContent
#download="$(curl -X GET "https://$tenant/ -H "Authorization: Bearer $apiKey")"
