#!/bin/bash

# Define your tenant url
tenant="$(cat ../secret/tenant)";
# Define your API key
apiKey="$(cat ../secret/api-key)";
# Define Space
space="$(cat ../secret/space)";

# Get Connection ID
connectionId=$(curl -s "https://$tenant/api/v1/data-connections" -H "Authorization: Bearer $apiKey" | jq '.data[]' | grep -2 "$space" | 
tail -1 | awk -F'"' '{print $4}');

# Define url
url="https://$tenant/api/v1/qix-datafiles?connectionId=$connectionId"

# List files
## Use Qlik cli to get list of file
result=$(/home/cyp/qlik data-file ls --connectionId $connectionId --limit 13000)
file=$(echo $result | jq --arg s '2016-10-21T20:51' --arg e '2023-06-29T08:09' 'map(select(.modifiedDate | . >= $s and . <= $e + "z") | select(.name|test(".qvd")) | .id)' | tr -d \") 
echo $file

for f in $file
do
        echo $f;
        if [ "$f" ]; then
                # Define url delete files
                # Delete file
                urlD="https://$tenant/api/v1/data-files/$f";
                result=$(curl -ks -X DELETE "$urlD" -H "Authorization: Bearer $apiKey");
                echo $result;
                sleep 4;
        fi
done
