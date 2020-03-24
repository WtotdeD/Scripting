#Connect to your azure subscription to RM or AZ
#Connect-AzAccount

#parameters need to change owner
param
(
    [string]$azad = "cld.aut.AzureData.cld.aut.SqlRdmsDEVPowerUser",
    [string] $subscription = "rabo-d02-ccc-consumers"
)
    
#Set context to rabo-do2 and assign ID to variable
$SubID = (Set-AzContext -SubscriptionName $subscription).subscription.SubscriptionID
Set-AzContext -SubscriptionId $SubID
#Get ID from out AZ group and assign to variable
$azadID =  (Get-AzADGroup -SearchString $azad).Id
Write-Host $azadID

#Get owner of our AZ group and assign to variable
Get-Az -o