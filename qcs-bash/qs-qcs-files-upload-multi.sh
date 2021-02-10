#!/bin/bash
# Define your tenant url
tenant="$(cat ../secret/tenant)";
# Define your API key
apiKey="$(cat ../secret/api-key)";
# Define Space
space="$(cat ../secret/space)";
# Define filename
directory="../files/*";
# Declare authorized extension
declare -a extension=("csv");

# Check list extension
in_array() {
    local haystack=${1}[@]
    local needle=${2}
    for i in ${!haystack}; do
        if [[ ${i} == ${needle} ]]; then
            return 0
        fi
    done
    return 1
}

# Get Connection ID
connectionId=$(curl -s "https://$tenant/api/v1/data-connections" -H "Authorization: Bearer $apiKey" | jq '.data[]' | grep -2 "$space" | tail -1 | awk -F'"' '{print $4}');

# Download multi file
for file in $directory
do
	if [ -f "$file" ]; then
		if in_array extension "${file##*.}" ]; then
			echo "------------Start Download file------------";
			echo $file;
			# Define url
			url="https://$tenant/api/v1/qix-datafiles?connectionId=$connectionId&name=$file";

			curl -X POST -# "$url" -H "Authorization: Bearer $apiKey" -H "content-type: multipart/form-data" -F data=@$file;
			sleep 3;
			echo "------------End Download file------------";
		fi
	fi
done
