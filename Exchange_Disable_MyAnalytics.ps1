$Mbx = Get-Mailbox -RecipientTypeDetails UserMailbox -ResultSize Unlimited | Select DisplayName, UserPrincipalName 
ForEach ($M in $Mbx) 
{
    Write-Host "Processing" $M.UserPrincipalName
	Set-UserAnalyticsConfig -Identity $M.UserPrincipalName -PrivacyMode "Opt-out"
}