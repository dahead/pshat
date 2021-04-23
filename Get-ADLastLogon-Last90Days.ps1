$d = (Get-Date).addDays(-90)
Get-ADComputer -Property LastLogonDate -Filter {lastLogonDate -lt $d} -SearchBase "OU=xxx,DC=xxx,DC=xxx,DC=de"  |
select DNSHostName, LastLogonDate > LastLogon.txt
