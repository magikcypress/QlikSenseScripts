#!/bin/bash

# Define your tenant url
tenant="$(cat ../secret/tenant)";
# Define your API key
apiKey="$(cat ../secret/api-key)";
# Define your space
space="$(cat ../secret/space)";

# Define Url Space
urlSpace="https://$tenant/api/v1/spaces";

# Get space Id
spaceId=$(curl -s "$urlSpace" -H "Authorization: Bearer $apiKey" | jq '.data[] | select(.name == '\"$space\"') | .id' | tr -d \");

# Define url assignment
url="https://$tenant/api/v1/spaces/$spaceId/assignments"

# Get Assignment
listAssig=$(curl -s -X GET "$url" -H "Authorization: Bearer $apiKey" | jq -r '.');
echo $listAssig;

# Define url Add user
url="https://$tenant/api/v1/spaces/$spaceId/assignments"

# Add User Assignment
assig=$(curl -s -X POST "$url" -H "Authorization: Bearer $apiKey" -d '{"type": "user", "assigneeId":"iuWz3WIBpkbaVPF8jTVZ43flt-cNb4ez", "roles":["consumer"]}');
echo $assig;
