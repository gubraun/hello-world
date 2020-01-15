#!/bin/bash

resourceGroupName="coverity"
storageAccountName="coveritystore"
fileShareName="cov-analysis-share"

mntPath="/mnt/$storageAccountName/$fileShareName"
sudo mkdir -p $mntPath

# This command assumes you have logged in with az login
httpEndpoint=$(az storage account show \
   --resource-group $resourceGroupName \
   --name $storageAccountName \
   --query "primaryEndpoints.file" | tr -d '"')

smbPath=$(echo $httpEndpoint | cut -c7-$(expr length $httpEndpoint))$fileShareName

storageAccountKey=$(az storage account keys list \
   --resource-group $resourceGroupName \
   --account-name $storageAccountName \
   --query "[0].value" | tr -d '"')

sudo mount -t cifs $smbPath $mntPath -o vers=3.0,username=$storageAccountName,password=$storageAccountKey,serverino,mfsymlinks
