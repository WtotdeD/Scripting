param 
(
    [string] $blobname = "rdmblobstorage",
    [string] $subscription = 'rabo-d02-ccc-consumers',
    [string] $rgname = "rg-d02-dev-sqldf-01",
    [string]$subscriptionName  = "rabo-d02-ccc-consumers",
    [string] $objectID = "3d120d7f-10e1-4772-8a8f-48413c6d1755"    
)


#connect to Az
Connect-AzAccount 
$SubID = (Set-AzContext -SubscriptionName $subscription).Subscription.ID
Write-Host $SubID
$TenantID = (Set-AzContext -SubscriptionName $subscription).Tenant.Id
Set-AzContext -SubscriptionId $SubID
Write-Host $TenantID

#Get server principal for AzAD
$azgroupID = (Get-AzADGroup -ObjectId $objectID).ID
$Get -ObjectId $objectID
Write-Host $azgroupID




#Get to blob account
$blobkv = (Get-AzResource -ResourceGroupName rg-d02-dev-sqldf-01 -ResourceType Microsoft.KeyVault/vaults -ResourceName *blob*).ResourceId
Write-Host $blobkv
#FOR the new AZ modules get all Storageaccount
$blobsa = (Get-AzResource -ResourceGroupName $rgname -ResourceType Microsoft.Storage/storageAccounts -ResourceName *blob*).Id
Write-Host $blobsa
$ctx = $storageAccount.Context

Get-AzStorageAccount -ResourceGroupName rg-d02-dev-sqldf-01 -Name "rdmblobstorage"
$containerName = "quickstartblobs"
new-azurestoragecontainer -Name $containerName -Context $ctx -Permission blob
Azbl

