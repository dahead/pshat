param (
    [string]$mail = $(throw "-mail is required."),
    [string]$text = $(throw "-text is required.")
)
write-output "Setting out of office reply for user user $mail with: $text"

Write-Host -NoNewLine 'Press any key to continue...';
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');

Set-MailboxAutoReplyConfiguration -Identity $mail -AutoReplyState Enabled -InternalMessage "$text" -ExternalMessage "$text"