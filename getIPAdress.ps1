####################### Select IP Adresses on HOST ###################

$ip = Get-CimInstance Win32_NetworkAdapter -Filter "NetConnectionID='WXYZ_ADMIN'" |
    Select-Object NetConnectionID,
                @{n='IPAdresi';e={
                    [IPAddress[]]($_ | Get-CimAssociatedInstance -ResultClassName Win32_NetworkAdapterConfiguration).IPAddress |
                        Where-Object AddressFamily -eq 'InterNetwork'
                }} | select IPAdresi | Format-Table -HideTableHeaders | Out-String | ForEach-Object { $_.Trim() }


####################### Use Selected IP via PSCP Connection Than Copy File Remote Linux Machine #########


$CopyFile_1 = 'pscp -l user-name -pw password -batch D:\XYZ\xyz-release\xyz-de.yml `"$ip`":/home/xyz/application/ddt/release'
Invoke-Expression "& $( $CopyFile_1 )"

####################### Use Selected IP via SSH Connection and Run Command ########

# $command = "ansible-playbook xyz_deploy.yml --extra-vars 'artifactoryUrl=http://X.X.X.X:8081/artifactory/XYZ/release releaseVersion=0.1.49'"
# echo y | & "D:\XYZ\xyz-release\plink.exe" -ssh $ip -i "D:\XYZ\xyz-release\id_rsa.pub"-l user-name -pw pass-word $command
