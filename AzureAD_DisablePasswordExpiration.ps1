param (
    [string]$mail = $(throw "-mail is required.")
)
write-output "Disabling password expiration in the cloud for user $mail."
Set-AzureADUser -ObjectId $mail -PasswordPolicies DisablePasswordExpiration