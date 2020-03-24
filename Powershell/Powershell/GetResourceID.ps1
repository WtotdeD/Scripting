<# 
      Example Azure PowerShell command to find Azure Ad group and see its members
#> 

#Connect to your azure subscription to RM or AZ
Connect-AzAccount
Connect-AzureRmAccount

#Set the context to the subscription needed#
$subscription = 'rabo-d02-ccc-consumers'
$SubID = (Set-AzContext -SubscriptionName $subscription).Subscription.subscriptionID
Set-AzContext -SubscriptionId $SubID

$SubId = (Set-AzureRmContext -SubscriptionName $subscription).Subscription.subscriptionID
Set-AzureRmContext -SubscriptionId $SubId


#Find a specific resource using its name
$resourceGroupName = 'rg-d02-dev-sqldf-01'
#FOR OLD RM Modules only FIND will work
Find-AzureRmResource -ResourceNameContains $resourceName| Format-Table
Get-AzureRmResource -ResourceNameContains $resourceName| Format-Table
Get-AzureRmResource -ResourceGroupName 'sqldf'| Format-Table

#FOR the new AZ modules get all keyvaults

$auditkv = (Get-AzResource -ResourceGroupName rg-d02-dev-rdmaudit-01 -ResourceType Microsoft.KeyVault/vaults -ResourceName *audit*).ResourceId
Write-Host $auditkv
$blobkv = (Get-AzResource -ResourceGroupName rg-d02-dev-sqldf-01 -ResourceType Microsoft.KeyVault/vaults -ResourceName *blob*).ResourceId
Write-Host $blobkv
#FOR the new AZ modules get all Storageaccount
$blobsa = (Get-AzResource -ResourceGroupName rg-d02-dev-sqldf-01 -ResourceType Microsoft.Storage/storageAccounts -ResourceName *blob*).ResourceId
Write-Host $blobsa
$auditsa = (Get-AzResource -ResourceGroupName rg-d02-dev-rdmaudit-01 -ResourceType Microsoft.Storage/storageAccounts -ResourceName *audit*).ResourceId
Write-Host $auditsa
#FOR the new AZ modules get all Datafactory
$blobdf = (Get-AzResource -ResourceGroupName rg-d02-dev-rdmaudit-01 -ResourceType Microsoft.DataFactory/factories -ResourceName *blob*).ResourceId
Write-Host $blobdf