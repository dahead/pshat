param (
    [string]$teamname = $(throw "-teamname is required."),
    [string]$mail = $(throw "-mail is required.")
)
write-output "Change primary mail adress for team $team to $mail."
Write-Host -NoNewLine 'Press any key to continue...';
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
Set-UnifiedGroup -Identity $teamname -PrimarySmtpAddress $mail