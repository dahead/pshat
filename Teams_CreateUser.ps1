param (
    [string]$mail = $(throw "-mail is required."),
    [string]$phone = $(throw "-phone is required with prefix +49.")
)
write-output "When problems occur: license assigned in AADC? Otherwise error message OnPremLineURI."
write-output "Create user $mail with $phone number."

Write-Host -NoNewLine 'Press any key to continue...';
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');

Set-Csuser -Identity "$mail" -OnPremLineURI "tel:$phone" -EnterpriseVoiceEnabled $true -HostedVoiceMail $true
Grant-CsOnlineVoiceRoutingPolicy -Identity "$mail" -PolicyName "Unrestricted"
Grant-CsTenantDialPlan -PolicyName "SCDialPlan" -Identity "$mail"
# Grant-CsConferencingPolicy -Identity $SolUser.UserPrincipalName -Verbose -PolicyName BposSDataProtection

Write-Host 'Setting up voicemail defaults.';
Set-CsOnlineVoicemailUserSettings -Identity $mail -PromptLanguage "de-DE" -VoicemailEnabled $true -OofGreetingEnabled $false -OofGreetingFollowCalendarEnabled $true -OofGreetingFollowAutomaticRepliesEnabled $true

# Get-CsOnlineUser "$mail"