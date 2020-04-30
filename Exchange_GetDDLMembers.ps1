param (
    [string]$name = $(throw "-name of the Dynamic Distribution list is required.")
)

$ddl = Get-DynamicDistributionGroup $name
Get-Recipient -RecipientPreviewFilter $ddl.RecipientFilter -OrganizationalUnit $ddl.RecipientContainer