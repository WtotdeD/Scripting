<# 
      Example Azure PowerShell Inline Task to Assign Access to a Service Account 
      on an Azure Resource from within an Azure DevOps Release Pipeline 
  
      Date: 28-11-2018 
      Author: Rabobank CCC 
#> 
 
Connect-AzureRmAccount
$SubId = (Set-AzureRmContext -SubscriptionName 'rabo-d02-ccc-consumers').Subscription.subscriptionID
Write-Host $SubId 
Set-AzureRmContext -SubscriptionId $SubId

Find-AzureRmResource -ResourceType Microsoft.KeyVault/vaults -ResourceNameEquals '*audit*'| Format-Table
Get-AzureRmResource | Where-Object -ResourceName -Like '*vault*'

Get-AzureRmADGroup -ObjectId 3d120d7f-10e1-4772-8a8f-48413c6d1755

Get-AzureRmADGroupMember -GroupObjectId 3d120d7f-10e1-4772-8a8f-48413c6d1755 

$servicePrincipalName = "$(spAcrReaderName)"
$password = "$(spAcrReaderPassword)"
$secpassw = ConvertTo-SecureString $password -AsPlainText -Force
$sp = Get-AzureRmADServicePrincipal -DisplayName $servicePrincipalName -ErrorAction SilentlyContinue
if (-not $sp) {
  # Create the service principal
  $sp = New-AzureRmADServicePrincipal -DisplayName $servicePrincipalName -Password $secpassw
  # Sleep a few seconds to allow the service principal to propagate throughout
  # Azure Active Directory
  Start-Sleep 15
}
# Output the service principal's credentials as pipeline variables
# Use these to authenticate to the container registry.
Write-Host ( "##vso[task.setvariable variable=spAcrReaderApplicationId]" + $sp.ApplicationId )
Write-Host ( "##vso[task.setvariable variable=spAcrReaderId]" + $sp.Id )