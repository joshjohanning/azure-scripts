#!/bin/bash
# https://thomasthornton.cloud/2021/05/08/copy-azure-keyvault-secrets-to-another-keyvault-using-azure-cli/

# chmod +x ./key-vault-list-missing.sh

# This script will simply list secrets that don't exist in target key vault when comparing to source

SOURCE_KEYVAULT="sourcekv-dev"
DESTINATION_KEYVAULT="targetkv-qa"
 
SECRETS+=($(az keyvault secret list --vault-name $SOURCE_KEYVAULT --query "[].id" -o tsv))
 
for SECRET in "${SECRETS[@]}"; do
 
SECRETNAME=$(echo "$SECRET" | sed 's|.*/||')
 
SECRET_CHECK=$(az keyvault secret list --vault-name $DESTINATION_KEYVAULT --query "[?name=='$SECRETNAME']" -o tsv)
 
 
if [ -n "$SECRET_CHECK" ]
then
    # echo "A secret with name $SECRETNAME already exists in $DESTINATION_KEYVAULT"
    test="do nothing"
else
    echo "$SECRETNAME"
fi
 
done