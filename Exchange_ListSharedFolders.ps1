Get-Mailbox -RecipientTypeDetails SharedMailbox -ResultSize:Unlimited | select Name, Alias | Export-Csv -Path .\SharedMailbox.txt -Delimiter ';' -Encoding ASCII -NoTypeInformation
