#!/bin/bash
# 
# 1. Verify you are logged into the correct Azure context by running az account show. If not, run az login
# 2. chmod +x ./keyvault-import.sh
# 3. Don't add a key/value pair to the last line of the CSV otherwise it will not be read
# 4. If using Excel to create/modify .csv, save as a a "Comma Separated Values (.csv)" file type, %NOT% CSV UTF-8 (Comma deliminited)
# 5. To run: ./keyvault-import.sh
set -euxo pipefail
INPUT="keyvault-import.csv"
KEYVAULT="my-kv-dev-kv"
OLDIFS=$IFS
IFS=','
[ ! -f $INPUT ] && { echo "$INPUT file not found"; exit 99; }
while read key value
do
	az keyvault secret set --vault-name $KEYVAULT --name $key --value $value
done < $INPUT
IFS=$OLDIFS