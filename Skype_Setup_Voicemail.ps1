param (
    [string]$mail = $(throw "-mail is required.")
)
write-output "Setting up voicemail for user user $mail."

Write-Host -NoNewLine 'Press any key to continue...';
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');

$SolUser = Get-CsOnlineUser -Identity "$mail"

$textWelcome = "Firma XXX, " + $SolUser.DisplayName
$textOOF = "Firma XXX, " + $SolUser.DisplayName + ". Zur Zeit ist niemand erreichbar."

Grant-CsConferencingPolicy -Identity $SolUser.UserPrincipalName -Verbose -PolicyName BposSDataProtection
Set-CsOnlineVoicemailUserSettings -Identity $SolUser.UserPrincipalName -PromptLanguage "de-DE" -VoicemailEnabled $true -OofGreetingEnabled $false -OofGreetingFollowCalendarEnabled $true -OofGreetingFollowAutomaticRepliesEnabled $true

# Set text
Set-CsOnlineVoicemailUserSettings -Identity $SolUser.UserPrincipalName -DefaultGreetingPromptOverwrite $textWelcome -DefaultOofGreetingPromptOverwrite $textOOF

# Set-CsOnlineVoicemailUserSettings -Identity $SolUser.UserPrincipalName -DefaultGreetingPromptOverwrite $textWelcome
# Set-CsOnlineVoicemailUserSettings -Identity $SolUser.UserPrincipalName -DefaultOofGreetingPromptOverwrite $textOOF
