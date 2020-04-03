New-CsTeamsFeedbackPolicy -Identity "Tenant Bar Feedback Policy" -UserInitiatedMode Disabled -ReceiveSurveysMode Disabled 
$Mbx = Get-Mailbox -RecipientTypeDetails UserMailbox -ResultSize Unlimited | Select DisplayName, UserPrincipalName 
ForEach ($M in $Mbx) 
{
    Write-Host "Processing" $M.DisplayName
    Grant-CsTeamsFeedbackPolicy -PolicyName "Tenant Bar Feedback Policy" -Identity $M.UserPrincipalName 
}
