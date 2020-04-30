# Download Powershell Addin via EDGE (!!!)
# https://outlook.office365.com/ecp/

param (
    [string]$username = $(throw "-username is required.")
)
Write-Host -NoNewLine 'Press any key to continue...';
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
Connect-EXOPSSession -UserPrincipalName $username