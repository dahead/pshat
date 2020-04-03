param (
    [string]$mail = $(throw "-mail is required.")
)
Connect-AzureAD
write-output "Revoke Azure Access for user $mail."
Write-Host -NoNewLine 'Press any key to continue...';
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
Revoke-AzureADUserAllRefreshToken -ObjectId "$mail"