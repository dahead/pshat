param (
	[string]$companyname = $(throw "-companyname is required."),
	[string]$nobodyreachable = $(throw "-nobodyreachable is required. Add on text for the unreachable option."),
	[string]$language = $(throw "-language is required (for example: de-DE).")
)
write-output "Setting up voicemail texts for users of §companyname $mail."

ForEach ($SolUser in Get-CsOnlineUser -Filter {ProvisionedPlan -ne $null} -ResultSize unlimited) 
{
	$textWelcome = "$companyname, " + $SolUser.DisplayName
	$textOOF = "$companyname, " + $SolUser.DisplayName + $nobodyreachable

	# write-output "Setting up VoiceMail OOF text for user" $SolUser.DisplayName
	# Write-Host -NoNewLine 'Press any key to continue...';
	# $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');

    	Grant-CsConferencingPolicy -Identity $SolUser.UserPrincipalName -Verbose -PolicyName BposSDataProtection
   	Set-CsOnlineVoicemailUserSettings -Identity $SolUser.UserPrincipalName -PromptLanguage $language -VoicemailEnabled $true -OofGreetingEnabled $false -OofGreetingFollowCalendarEnabled $true -OofGreetingFollowAutomaticRepliesEnabled $true
	
	# Set text
	Set-CsOnlineVoicemailUserSettings -Identity $SolUser.UserPrincipalName -DefaultGreetingPromptOverwrite $textWelcome
	Set-CsOnlineVoicemailUserSettings -Identity $SolUser.UserPrincipalName -DefaultOofGreetingPromptOverwrite $textOOF	
}
