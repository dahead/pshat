# Shared Mailbox wurde auf vollwertiges Postfach umgestellt.
# Danach diese Optionen setzen und es ist ein "vollwertiges" Postfach.

param (
    [string]$mail = $(throw "-mail Name of mailbox to upgrade features required.")
)
write-output "Upgrading mailbox $mail."
Write-Host -NoNewLine 'Press any key to continue...';
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');

Set-Mailbox $mail -MessageCopyForSentAsEnabled:$True -MessageCopyForSendOnBehalfEnabled:$True