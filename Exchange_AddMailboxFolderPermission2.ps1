param (
    [string]$mail = $(throw "-mailFrom is required."),
	[string]$mail = $(throw "-mailTo is required."),
)
write-output "Add Mailbox Folder and Calendar Permission vom $mailFrom to $mailTo?"
Write-Host -NoNewLine 'Press any key to continue...';
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
# Mailbox Folder permission
Add-MailboxFolderPermission -Identity $mailFrom:\Calendar -User $mailTo -AccessRights Editor -SharingPermissionFlags Delegate,CanViewPrivateItems
# Calendar permission
Add-MailboxPermission -Identity $mailFrom -User $mailTo -AccessRights FullAccess -InheritanceType All