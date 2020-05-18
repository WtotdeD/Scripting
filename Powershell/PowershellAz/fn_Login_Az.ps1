#function to login to Az
function Login($SubscriptionId)
{
    $context = Get-AzContext

    if (!$context -or ($context.Subscription.Id -ne $SubscriptionId)) 
    {
        Connect-AzAccount -Subscription $SubscriptionId
    } 
    else 
    {
        Write-Host "SubscriptionId '$SubscriptionId' already connected"
    }
}
