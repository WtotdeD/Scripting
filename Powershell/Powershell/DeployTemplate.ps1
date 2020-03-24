# Connect to azure
Connect-AzureRmAccount 

Get-AzurePublishSettingsFile

# Get subscriptionID from DEV endpoint
Get-AzureRmSubscription -SubscriptionName rabo-d02-ccc-consumers 

#Get SubscriptionID get TenantID SubscriptionID
$SubId = (Set-AzureRmContext -SubscriptionName 'rabo-d02-ccc-consumers').Subscription.subscriptionID
Set-AzureRmContext -SubscriptionId $SubId
Write-Host $SubId
$tenantID = (Get-AzureRmContext).Tenant.TenantID
Write-Host $tenantID


#Make new empty RG with template file
New-AzureRmResourceGroup parentdev -Location 'West Europe'
New-AzureRmResourceGroupDeployment  
-ResourceGroupName parentdev
-TemplateUri https://raboweb.visualstudio.com/_git/RDMS/ScriptsPowershell/parent-dev-rg.json


New-AzureRmDeployment -Name "rg1" -Location "West Europe" -TemplateParameterFile .\template.parameters.json -TemplateFile .\template.json
 



  


  