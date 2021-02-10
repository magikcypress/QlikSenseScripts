#!/bin/bash

# Define your tenant url
tenant="$(cat ../secret/tenant)";
# Define your API key
apiKey="$(cat ../secret/api-key)";

# Define url reload
url="https://$tenant/api/v1/items/5e5010f60e7fd80001be9da0";

# Get items
item="$(curl -s -X GET "$url" -H "Authorization: Bearer $apiKey")";
