#!/bin/bash

# Define your tenant url
tenant="$(cat secret/tenant)";
# Define your API key
apiKey="$(cat secret/api-key)";
# Define Space
space="$(cat secret/space)";
# Date now
dateLast3Day=$(date +"%Y-%m-%d" -d "3 day ago");

# Get Connection ID
connectionId=$(curl -s "https://$tenant/api/v1/data-connections" -H "Authorization: Bearer $apiKey" | jq '.data[]' | grep -2 "$space" | tail -1 | awk -F'"' '{print $4}');

# Define url
url="https://$tenant/api/v1/qix-datafiles?connectionId=$connectionId"

# List files
result=$(curl -s "$url" -H "Authorization: Bearer $apiKey");
# get id file (filter csv file)
file=$(echo $result | jq --arg dateLast3Day "$dateLast3Day" '.[] | select(.createdDate|test("'$dateLast3Day.'")) | select(.name|test(".csv")) | .id' | tr -d \");

for f in $file
do
        echo $f;
        if [ "$f" ]; then
                # Define url delete files
                urlD="https://$tenant/api/v1/qix-datafiles/$f";
                # Delete file
                result=$(curl -ks -X DELETE "$urlD" -H "Authorization: Bearer $apiKey");
                echo $result;
        fi
done
