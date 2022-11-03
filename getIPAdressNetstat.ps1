########################## Select Local Machine to Running 22 port IP adresses =============

Get-NetTCPConnection | select LocalAddress*, LocalPort* | where {$_.LocalPort -eq "139"}  |  Where {$_.LocalAddress -like '192.168.*.*'} | Select-Object LocalAddress | Select-Object -First 1 | Format-Table -HideTableHeaders | Out-String | ForEach-Object { $_.Trim() }
