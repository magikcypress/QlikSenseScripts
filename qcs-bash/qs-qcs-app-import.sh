#!/bin/bash

# Define your tenant url
tenant="$(cat ../secret/tenant)";
# Define your API key
apiKey="$(cat ../secret/api-key)";
# Define your space
space="$(cat ../secret/space)";
# Define filename
filename='../files/Ecoles-Françaises.qvf';

# Define Url Space
urlSpace="https://$tenant/api/v1/spaces";

# Get space Id
spaceId=$(curl -s "$urlSpace" -H "Authorization: Bearer $apiKey" | jq '.data[] | select(.name == '\"$space\"') | .id' | tr -d \");

# Define url import
urlImport="https://$tenant/api/v1/apps/import?spaceId=$spaceId";

# Import file
import="$(curl -s -X POST "$urlImport" -H "Content-Type: application/octet-stream" --data-binary "@$filename" -H "Authorization: Bearer $apiKey")";

# Save App Id into file
echo $import | jq '.attributes | .id' | tr -d \" > ../secret/app-id;

#echo $import | jq 

# Create Body app for item
name=$(echo $import | jq '.attributes | .name' | tr -d \");
id=$(echo $import | jq '.attributes | .id' | tr -d \");
ownerId=$(echo $import | jq '.attributes | .ownerId' | tr -d \");
createdDate=$(echo $import | jq '.attributes | .createdDate' | tr -d \");

appBody=$( jq -n \
		--arg name "$name" \
		--arg id "$id" \
		--arg ownerId "$ownerId" \
		--arg spaceId "$spaceId" \
		--arg createdDate "$createdDate" \
		'{
			name: $name,
			resourceAttributes: {
				"_resourcetype": "app",
				id: $id,
				name: $name,
				ownerId: $ownerId
			},
			"resourceType": "app",
			resourceId: $id,
			resourceCreatedAt: $createdDate,
			spaceId: $spaceId,
			ownerId: $ownerId
		}';
	)

# Define url Items
urlItem="https://$tenant/api/v1/apps/items";

# Change Item
item="$(curl -s -X POST "$urlItem" -H "Content-Type: application/javascript" -H "Authorization: Bearer $apiKey" -d $appBody)";
