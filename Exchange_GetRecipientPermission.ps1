param (
    [string]$mail = $(throw "-mail is required.")
)

Write-Host -NoNewLine 'Press any key to continue...';
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');


Get-RecipientPermission -Identity $mail -AccessRights sendas | where {($_.trustee -like '*@*') }