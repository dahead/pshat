### Exchange 

## Login mit MFA

```
Connect-ExchangeOnline -UserPrincipalName myadminuser@mycompany.de -ShowProgress $True
```

## Mails Tipps anzeigen

```
Set-OrganizationConfig -MailTipsExternalRecipientsTipsEnabled $true
```

## External Mail Flag anzeigen

```
Set-ExternalInOutlook -Enabled $true
```
See: 
- https://www.bleepingcomputer.com/news/microsoft/microsoft-365-adds-external-email-tags-for-increased-security/
- https://docs.microsoft.com/en-us/powershell/module/exchange/set-externalinoutlook?view=exchange-ps
