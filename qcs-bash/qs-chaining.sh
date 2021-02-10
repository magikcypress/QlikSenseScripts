#!/bin/bash

echo "------------------Import application";

./qs-qcs-app-import.sh;
sleep 10;


echo "------------------Import Datafile";

./qs-qcs-files-upload.sh
sleep 10;

echo "------------------Reload app";

./qs-qcs-app-reload.sh;
sleep 10;

echo "------------------Upload more Datafile";

./qs-qcs-files-upload-multi.sh;
sleep 10;

echo "------------------Reload app";

./qs-qcs-app-reload.sh


