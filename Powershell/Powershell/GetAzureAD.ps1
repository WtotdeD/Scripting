param 
(
    [string] $blobname          ="rdmblobstorage",
    [string] $subscription      ="rabo-d02-ccc-consumers",
    [string] $rgname            ="rg-d02-dev-sqldf-01",
    [string]$rgname01           ="rg-d02-dev-rdmdev-01"
)


#connect to Azure
Connect-AzureRMAccount 
#Get subscription
$SubID = (Set-AzureRmContext -SubscriptionName $subscription).Subscription.ID
Write-Host "The SUB ID is $SubID" -ForegroundColor Yellow 
#Set context to subscription
Set-AzureRmContext $SubID
$TenantID = (Set-AzureRMContext -SubscriptionName $subscription).Tenant.Id
Write-Host "The tenant ID is $TenantID" -ForegroundColor Yellow


#Get  resource
Write-Host "Get keyvault for resourcegroup $rgname " -ForegroundColor Green
$KV = (Get-AzureRmKeyVault -ResourceGroupName rg-d02-dev-sqldf-01).ResourceId
Write-Host "The keyvaultID is $KV" -ForegroundColor Yellow
#Get resource for storage account
Write-Host "Get storage for resourcegroup $rgname " -ForegroundColor Green
$SA = (Get-AzureRmStorageAccount -ResourceGroupName rg-d02-dev-sqldf-01).Id
Write-Host "The keyvaultID is $SA" -ForegroundColor Yellow





