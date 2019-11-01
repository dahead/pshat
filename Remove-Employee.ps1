<#
.COPYRIGHT
Copyright (c) dh. All rights reserved. Licensed under the MIT license.
See LICENSE in the project root for license information.
#>

####################################################

function Remove-Employee {

    <#
    .SYNOPSIS
    This function is used to remove an employee from everything in the office 365 world.
    .DESCRIPTION
    The function...
    .EXAMPLE
    Remove-Employee -username bill@ms.com -substitute admin@ms.com
    .NOTES
    NAME: Remove-Employee
    #>
    
[cmdletbinding()]          
    
param 
(
    [Parameter(Mandatory=$true)]
    [string]$username = $(throw "-username is required."),
    [Parameter(Mandatory=$true)]
    [string]$substitute = $(throw "-substitute is required.")
)


function Get-RandomCharacters($length, $characters) { 
    $random = 1..$length | ForEach-Object { Get-Random -Maximum $characters.length } 
    $private:ofs = "" 
    return [String]$characters[$random]
}


########################################################################################
########################################################################################
########################################################################################

Write-Host "Connecting to MS Online..."
# Install-Module MSOnline
Import-Module MSOnline
$myCred = Get-Credential 
$Session = Connect-MsolService –Credential $myCred

# Block an Office user account
Write-Host "Blocking user credentials..."
Set-MsolUser -UserPrincipalName $username -BlockCredential $true

Write-Host "Setting password to random password..."
$randpw = Get-RandomCharacters -length $newpasswordlength -characters 'abcdefghiklmnoprstuvwxyz01234567890!@#$%^&*()_+{}:"<>?'
Write-Host "Password is: " $randpw
Set-MsolUserPassword -UserPrincipalName $username -NewPassword $randpw
# Set-MsolUserPassword -UserPrincipalName "davidchew@contoso.com" -ForceChangePassword
# Set-MsolUserPassword –UserPrincipalName "user@domain.com" –NewPassword "pass@word1" -ForceChangePassword $False


# Remove and delete the Office 365 license from a former employee
Write-Host "Remvoing users licenses..."
(Get-MsolUser -UserPrincipalName $username).licenses.AccountSkuId |
foreach{
    Set-MsolUserLicense -UserPrincipalName $upn -RemoveLicenses $_
}



# Remove Session
Write-Host "Disconnecting from MS Online..."
if ($Session)
{
    Remove-PSSession -Session $Session
} 


#    In the admin center, go to the Users > Active users page.
#    Select the box next to the user's name, and then select Reset password.
#    Enter a new password, and then select Reset. (Don't send it to them.)
#    Select the user's name to go to their properties pane, and on the OneDrive tab, select Initiate sign-out.



########################################################################################
########################################################################################
########################################################################################

# Open PowerShell as Administrator.
Write-Host "Connecting to Azure AD..."
$Session = Connect-AzureAD -Credential $myCred

# Revoke user access
Write-Host "Revoking user access..."
Get-AzureADUser -SearchString $username | Revoke-AzureADUserAllRefreshToken 

# block access to the user account
Write-Host "Disable user account..."
Set-AzureADUser -ObjectID $username -AccountEnabled $false


# Remove Session
Write-Host "Disconnecting from Azure AD..."
if ($Session)
{
    Remove-PSSession -Session $Session
} 



########################################################################################
########################################################################################
########################################################################################

Write-Host "Connecting to Exchange Online..."
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $myCred -Authentication Basic -AllowRedirection
Import-PSSession $Session -DisableNameChecking

# Forward a former employee's email to another employee or 
# convert to a shared mailbox
Write-Host "Convert users mailbox to a shared mailbox..."
Set-Mailbox -Identity $username -Type Shared

Write-Host "Adding permission for substitute..."
Add-MailboxPermission -Identity $username -User $substitute -AccessRights FullAccess -InheritanceType all


# Wipe and block a former employee's mobile device
# Get-MobileDevice -Mailbox $username | Select FriendlyName,DeviceType,ClientVersion,ClientType
Write-Host "Wiping and blocking remote devices..."
# https://docs.microsoft.com/en-us/powershell/module/exchange/devices/get-mobiledevice?view=exchange-ps
Get-MobileDevice -Mailbox m$username | Clear-MobileDevice -AccountOnly -Confirm:$false


Write-Host "Disconnecting from Exchange Online..."
if ($Session)
{
    Remove-PSSession -Session $Session
} 




########################################################################################
########################################################################################
########################################################################################





# Block a former employee's access to Office 365 data
# Block this user.


# Block a former employee's access to email (Exchange Online)


