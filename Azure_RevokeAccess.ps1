param (
    [string]$mail = $(throw "-mail is required."),
)
write-output "Revoke Access for user $mail?"
Write-Host -NoNewLine 'Press any key to continue...';
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
# Set-AzureADUser -ObjectId $mail -AccountEnabled $false
Revoke-AzureADUserAllRefreshToken -ObjectId $mail
# Get-AzureADUserRegisteredDevice -ObjectId $mail | Set-AzureADDevice -AccountEnabled $false