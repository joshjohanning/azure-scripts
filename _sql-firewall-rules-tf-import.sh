# use this script to help unwind your sql firewall rules from tf state and re-add them
# useful if you've done a lot of modifications in the portal and want to import in bulk

# permissions issue? run: chmod +x ./_sql-firewall-rules-tf-import.sh 

# get list of firewall rules
# az sql server firewall-rule list -g my-RG -s my-sql-dev

# make sure we're in the right workspace environment!
terraform workspace select dev

# remove existing terraform state - if needed
# terraform state rm azurerm_sql_firewall_rule.sql

# add existing rules to state - rule names are case sensitive
terraform import 'azurerm_sql_firewall_rule.sql["AllowAllWindowsAzureIps"]' "/subscriptions/***********//resourceGroups//***********//providers/Microsoft.Sql/servers/***********//firewallRules/AllowAllWindowsAzureIps"
terraform import 'azurerm_sql_firewall_rule.sql["Josh"]' "/subscriptions//***********/resourceGroups//***********/providers/Microsoft.Sql/servers/***********/firewallRules/Josh"

# example with apostrophe
terraform import "azurerm_sql_firewall_rule.sql[\"Josh's Office\"]" "/subscriptions/***********/resourceGroups//***********//providers/Microsoft.Sql/servers/***********/firewallRules/Josh's Office"