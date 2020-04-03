param (
    [string]$mail = $(throw "-mail is required."),
    [string]$mailnickname = $(throw "-mailnickname is required.")
)
write-output "Adding $mail to Teams $mainickname."

Write-Host -NoNewLine 'Press any key to continue...';
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');

$group = Get-Team -MailNickname $mailnickname
Add-TeamUser -GroupId $group.GroupId -User $mail