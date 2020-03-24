## Connect to azure
#Check what modules are installed
Get-InstalledModule -Name AZ -AllVersions
Get-InstalledModule -Name AzureRM -AllVersions
    Uninstall
## Understand the basicz of AzureAD, ResourceManager and AzureServiceManager
#Check if you have an azure service management loaded works only by accepting a certificate and can only acces service-manager cmdlets
Get-AzureSubscription
    #to set it up download certificate 
    Import-AzurePublishSettingsFile #blocked by Rabobank
    #to remove
    Remove-AzureSubscription

#Check if you have logged in with Resource Manager
Get-AzureRmSubscription 
    #If noy you can connect with the Azure Resource Manager
    Connect-AzureRmAccount 
    Remove-AzureRmAccount
    Uninstall-AzureRm
    

#Check if you logged in with AzureAD this can acces both cmdlets. This is preffered way but seems disabled
Get-AzureAccount
    #If not add Azure Add group
    Add-AzureAccount
    #Uninstall 
    Uninstall


##Set parameters
#Set context
$DFname = '*audit*'
$SubId = (Set-AzureRmContext -ResourceGroupName rg-d02-dev-rdmaudit-01).Subscription.subscriptionID
Set-AzureRmContext -SubscriptionId $SubId
#Set Resourcegroup for DF
$RGDatafactory = (Get-AzureRmResourceGroup | Where-Object ResourceGroupName -like $DFname).ResourceGroupName.string
Write-Host $RGDatafactory
$dataFactoryName = (Get-AzureRmDataFactory -ResourceGroupName  rg-d02-dev-rdmaudit-01 -Name LocalToBlobDF).DataFactoryName
Write-Host $dataFactoryName

Get-AzureRmDataFactory -ResourceGroupName  rg-d02-dev-rdmaudit-01 -Name LocalToBlobDF



Get-AzureRmDataFactory -ResourceGroupName rg-d02-dev-rdmaudit-01 -Name LocalToBlobDF
#Get DF name from permanent RG
#Get-AzureRmDataFactory  | Where-Object ResourceGroupName -EQ $RGDatafactory
#| Where name -Like 'DF'| Wher



#Get SubscriptionID get TenantID SubscriptionID
$SubId = (Set-AzureRmContext -SubscriptionName 'rabo-d02-ccc-consumers').Subscription.subscriptionID
Set-AzureRmContext -SubscriptionId $SubId
Write-Host $SubId
$tenantID = (Get-AzureRmContext).Tenant.TenantID
Write-Host $tenantID
$resourceGroupName = to.string((Get-AzureRmResourceGroup where -ResourceGroupName -like $dataFactoryName))
Write-Host $resourceGroupName

#Set parameters for selfhosted integration
Set-AzureRmDataFactoryV2IntegrationRuntime -ResourceGroupName $resourceGroupName -DataFactoryName $dataFactoryName -Name $selfHostedIntegrationRuntimeName -Type SelfHosted -Description "selfhosted IR description"

.. New-AzureRmDataFactoryV2IntegrationRuntimeKey · Remove-AzureRmDataFactoryV2IntegrationRuntime · Set-AzureRmDataFactoryV2IntegrationRuntime

#Install

#
Get-AzureRmDataFactoryV2IntegrationRuntimeKey -ResourceGroupName $resourceGroupName -DataFactoryName $dataFactoryName -Name $selfHostedIntegrationRuntime.

set-AzureRmDataFactoryV2IntegrationRuntimeKey