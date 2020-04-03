# Skype Powershell needed for this.
param (
    [string]$mail = $(throw "-mail is required."),
    [string]$phone = $(throw "-phone is required with prefix +49.")
)
write-output "Testing user $mail dialing $phone number."


Write-Host -NoNewLine 'Press any key to continue...';
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');

Get-CsEffectiveTenantDialPlan -Identity "$mail" | Test-CsEffectiveTenantDialPlan -DialedNumber "tel:$phone"