$subscription_hash = @{}
$subscription_hash = Get-AzSubscription
$resource_objects = @()
foreach ($subscription in $Subscription_hash) {
    Set-AzContext -SubscriptionId $subscription.id
    $resource_objects = $resource_objects + (Get-AzResource | Select-Object @{Name = 'Subscription'; Expression = {$subscription.name}}, ResourceType, Name, Location)
}
$date = get-date -format yyyyMMdd
$resource_objects | Select-Object * | Sort-Object -Property @{Expression = "Subscription"; Descending = $True},  @{Expression = "Location"; Ascending = $True}, @{Expression = "ResourceType"; Ascending = $True} | Export-Csv -Path ./$date-azure-resource-dump.csv