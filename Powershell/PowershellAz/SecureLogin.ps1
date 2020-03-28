
param 
(
    [string]$appName = "D01-APP-CAS-002",
    [string]$tenantId = "6e93a626-8aca-4dc1-9191-ce291b4b75a1",
    [string]$vaultName = "KV-D01-APP-CAS-002",
    [string]$subscriptionName  = "rabo-d03-ccc-pcf"
)

Write-host "Would you like to authenticate (Default is No)" -ForegroundColor Yellow
$Readhost = Read-Host " ( y / n ) "
if (([string]$ReadHost).ToLower() -ne 'y')
{
    return
}

$servicePrincipalName = "https://$appName"
$servicePrincipalVault = "https://$appName-KV"

if ([string]::IsNullOrEmpty($vaultName)) {
    $vaultName = "KV-$appName"
}

Connect-AzureRmAccount
Set-AzureRmContext -Subscription $subscriptionName

$appPrincipalId = (Get-AzureRmADServicePrincipal -ServicePrincipalName $servicePrincipalName).ApplicationId
Write-Host "Setting GREEN service principal secret"

#generate a random password
$KeyLengthBytes = 32
$ByteArray = New-Object Byte[] $KeyLengthBytes
$RNGCryptoSP = New-Object System.Security.Cryptography.RNGCryptoServiceProvider
$RNGCryptoSP.GetBytes($ByteArray)

Remove-Variable -Name RNGCryptoSP -ErrorAction SilentlyContinue
$password = [Convert]::ToBase64String($ByteArray)
$secureGreenPassword = ConvertTo-SecureString $password -AsPlainText -Force

# Set the password of the GREEN Service Principal
$appId = (Get-AzureRmADServicePrincipal -ServicePrincipalName $servicePrincipalVault).ApplicationId
New-AzureRmADAppCredential -ApplicationId $appId -EndDate (Get-Date).AddMinutes(5) -Password $secureGreenPassword

# apparently some time is needed before the credential can be used to login
Write-Host "Wait 40 Seconds..."
Start-Sleep -Seconds 40

$secureCredential = New-Object System.Management.Automation.PSCredential ($appId, $secureGreenPassword)

# Get the secret of the RED Service Principal that has deployment rights
Write-Host "Retrieving RED KEY deployment secret"
Add-AzureRmAccount -ServicePrincipal -Credential $secureCredential -TenantId $tenantId -ErrorAction Stop
$deploySecret = Get-AzureKeyVaultSecret -VaultName $vaultName -Name $appName -ErrorAction Stop

Write-Host "RED Principal id: " $appPrincipalId
Write-Host "RED Deploy secret: " $deploySecret.SecretValueText

# Login wit the RED Principal using retrieved deploy secret
$securePrincipalPassword = ConvertTo-SecureString $deploySecret.SecretValueText -AsPlainText -Force
$securePrincipalCredential = New-Object System.Management.Automation.PSCredential ($appPrincipalId, $securePrincipalPassword)

Write-Host "Login with the RED Principal"
Add-AzureRmAccount -ServicePrincipal -Credential $securePrincipalCredential -TenantId $tenantId
