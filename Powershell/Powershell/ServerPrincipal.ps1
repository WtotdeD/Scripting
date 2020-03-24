#how to make a secure Login

param 
(
    [string]$Name = "d02-dev-rdmsdev01-deploy",
    [string]$tenantId = "6e93a626-8aca-4dc1-9191-ce291b4b75a1",
    [string]$vaultName = "rdmkeyvaultblob",
    [string]$subscriptionName  = "rabo-d02-ccc-consumers"
)


#Service principal from our own 
$servicePrincipalName = "https://raboweb.onmicrosoft.com/$Name"
$servicePrincipalName1 = "https://$Name"

Write-Host "This our principal $servicePrincipalName1" -ForegroundColor Yellow
Write-Host "This is our Keyvault: $keyvaultName" -ForegroundColor Yellow

Write-host "Would you like to authenticate (Default is No)" -ForegroundColor Yellow
$Readhost = Read-Host " ( y / n ) "
if (([string]$ReadHost).ToLower() -ne 'y')
{
    return
}

# Add the account with your personal loging this is needed to obtain principals
Add-AzureRmAccount

#Generate a random secret
$KeyLengthBytes = 32
$ByteArray = New-Object Byte[] $KeyLengthBytes
$RNGCryptoSP = New-Object System.Security.Cryptography.RNGCryptoServiceProvider
$RNGCryptoSP.GetBytes($ByteArray)

Remove-Variable -Name RNGCryptoSP -ErrorAction SilentlyContinue
$password = [Convert]::ToBase64String($ByteArray)
$secureGreenPassword = ConvertTo-SecureString $password -AsPlainText -Force

$appId= (Get-AzureRmADServicePrincipal -ServicePrincipalName $servicePrincipalName).ApplicationId
Write-Host $appId 
New-AzureRmADCredential -ApplicationId $appId –EndDate (Get-Date).AddHours(3) –Password $secureGreenPassword
#c.Set the secret of the Service Principal
#Set random secret
#First get app ID and safe it to a variable


$appId= (Get-AzureRmADServicePrincipal -DisplayName $Name).ApplicationId
Write-Host "The applicationID = $appId" -ForegroundColor Yellow



$securePassword = ConvertTo-SecureString $password -AsPlainText -Force
$secureCredential= New-Object System.Management.Automation.PSCredential ($appId, $securePassword)



Add-AzureRmAccount –ServicePrincipal –Credential $secureCredential –TenantId 6e93a626-8aca-4dc1-9191-ce291b4b75a1



#Create a new credential
New-Azure

New-AzureAzADAppCredential -ApplicationId $appId –EndDate (Get-Date).AddHours(3) –Password $password
New-AzADAppCredential -ApplicationId $appId -EndDate (Get-Date).AddHours(3) -Password $securePassword
New-AzADCredential -ApplicationId $appId -EndDate (Get-Date).AddHours(3) -Password $securePassword





#
$servicePrincipalName = "https://raboweb.onmicrosoft.com/$Name"
Write-Host $servicePrincipalName
# Do we need this $servicePrincipalVault = "https://$appName-KV"






#Connect to Az account and set context
#Connect-AzAccount
Set-AzContext -Subscription $subscriptionName

#Assign ApplicationID to variable PrincipalID
$PrincipalID = (Get-AzADServicePrincipal -ServicePrincipalName $servicePrincipalName ).ApplicationId
Write-Host $PrincipalID



Connect-AzureRmAccount -ServicePrincipal -Credential 
Connect-AzAccount -ServicePrincipal -ApplicationId  $PrincipalID 
















<#
#Set the green principal
Write-Host "Setting the GREEN service principal secret"

#Generate a random password and store in variable for the greenpassword
$KeyLengthBytes = 32
$ByteArray = New-Object Byte[] $KeyLengthBytes
$RNGCryptoSP = New-Object System.Security.Cryptography.RNGCryptoServiceProvider
$RNGCryptoSP.GetBytes($ByteArray)

Remove-Variable -Name RNGCryptoSP -ErrorAction SilentlyContinue
$password = [Convert]::ToBase64String($ByteArray)
$secureGreenPassword = ConvertTo-SecureString $password -AsPlainText -Force

# Set the password of the GREEN Service Principal
#$appId = (Get-AzureRmADServicePrincipal -ServicePrincipalName $servicePrincipalVault).ApplicationId hebben wij nog niet
New-AzADServicePrincipalCredential -ApplicationId $PrincipalID -EndDate (Get-Date).AddMinutes(5) -Password $secureGreenPassword

# Some time is needed before the credential can be used to login
Write-Host "Wait 40 Seconds..."
Start-Sleep -Seconds 40

# Assign secure credential to variable
$secureCredential = New-Object System.Management.Automation.PSCredential ($appId, $secureGreenPassword)

# Get the secret of the RED Service Principal that has deployment rights
Write-Host "Retrieving RED KEY deployment secret"
Add-AzAccount -ServicePrincipal -Credential $secureCredential -TenantId $tenantId -ErrorAction Stop
#$deploySecret = Get-AzureKeyVaultSecret -VaultName $vaultName -Name $appName -ErrorAction Stop

#Write-Host "RED Principal id: " $appPrincipalId
#Write-Host "RED Deploy secret: " $deploySecret.SecretValueText

# Login wit the RED Principal using retrieved deploy secret
#$securePrincipalPassword = ConvertTo-SecureString $deploySecret.SecretValueText -AsPlainText -Force
#$securePrincipalCredential = New-Object System.Management.Automation.PSCredential ($appPrincipalId, $securePrincipalPassword)

#Write-Host "Login with the RED Principal"
#Add-AzureRmAccount -ServicePrincipal -Credential $securePrincipalCredential -TenantId $tenantId
#>