#!/bin/bash

# Define your tenant URL
tenant="$(cat ../secret/tenant)";
# Define your API key
apiKey="$(cat ../secret/api-key)";

# Get Spaces
curl -s "https://$tenant/api/v1/spaces" -H "Authorization: Bearer $apiKey" | jq '.data' | jq '.[].id';

# Get Collections
curl -s "https://$tenant/api/v1/collections" -H "Authorization: Bearer $apiKey" | jq;

# Get Connection ID
curl -s "https://$tenant/api/v1/data-connections" -H "Authorization: Bearer $apiKey" | jq;

# Get Files
curl -s "https://$tenant/api/v1/qix-datafiles" -H "Authorization: Bearer $apiKey" | jq;

# Get Groups info
curl -s "https://$tenant/api/v1/qlik-groups/B8GvT7XQ1C6j3TBZ6wYo1O3TBSAew2dp" -H "Authorization: Bearer $apiKey" | jq;
