#!/bin/bash
# Define your tenant url
tenant="$(cat ../secret/tenant)";
# Define your API key
apiKey="$(cat ../secret/api-key)";
# Define your Space
space="$(cat ../secret/space)";
# Define filename
directory="../files/*";

# Get connection ID
connectionId=$(curl -s "https://$tenant/api/v1/data-connections" -H "Authorization: Bearer $apiKey" | jq '.data[]' | grep -2 "$space" | tail -1 | awk -F'"' '{print $4}');

# Get file ID
fileId=$(curl -s "https://$tenant/api/v1/qix-datafiles?connectionId=$connectionId" -H "Authorization: Bearer $apiKey" | jq -r ".[] | .id");

# Delete multi file
for file in $fileId
do
	if [ "$file" ]; then
		echo "------------Start Delete file------------";
		echo "FileId : $file";
		# Define url
		url="https://$tenant/api/v1/qix-datafiles/$file";

		curl -k -X DELETE -# "$url" -H "Authorization: Bearer $apiKey";
		sleep 5;
		echo "------------End Delete file------------";
	fi
done
