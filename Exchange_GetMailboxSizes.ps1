$AllMailbox = Get-mailbox -resultsize unlimited

Foreach($Mbx in $AllMailbox)

{

	# Liste
	$Stats = Get-mailboxStatistics -Identity $Mbx.distinguishedname -WarningAction SilentlyContinue
	$userObj = New-Object PSObject
	$userObj | Add-Member NoteProperty -Name "Display Name" -Value $mbx.displayname
	$userObj | Add-Member NoteProperty -Name "Primary SMTP address" -Value $mbx.PrimarySmtpAddress
	$userObj | Add-Member NoteProperty -Name "TotalItemSize" -Value $Stats.TotalItemSize
	$userObj | Add-Member NoteProperty -Name "ItemCount" -Value $Stats.ItemCount
	Write-Output $Userobj

}


Foreach($Mbx in $AllMailbox)

{

	# Summe
	$Stats = Get-mailboxStatistics -Identity $Mbx.distinguishedname -WarningAction SilentlyContinue	
	$currentsize = $Stats.TotalItemSize.Value -replace '.*\(| bytes\).*|,' | % {'{0:N2}' -f ($_ / 1mb)}	
	Write-Output $mbx.displayname " size: " $currentsize	
	$totalsize = [int]$totalsize + [int]$currentsize
	Write-Output "Total: " $totalsize

}
