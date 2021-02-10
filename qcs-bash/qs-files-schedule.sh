#!/bin/bash

# Check file
appId=$(cat ../secret/app-id);
lastFile=$(cat ../secret/list-files | jq '. | length');
actualFile=$(sh qs-qcs-files-list.sh | jq '.id' | wc -l);

if [[ $lastFile -ne 0 ]]  && [[ $appId ]]; then
	if [ ${actualFile##*( )} -eq ${lastFile##*( )} ]
	then
		echo "Nothing to do!";
		echo "There was $actualFile, now there is $lastFile";
	else
		echo "New file added ... let's reload the applications";
		sh qs-qcs-app_reload.sh 
	fi
else
	echo "Nothing to do! Not appId or List File";
fi
