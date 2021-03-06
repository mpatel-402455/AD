# This script can be used to list group membership in Active Directory

#GList.CSV >>>GroupName  "CN=CTX EPI PRISM USERS,OU=Citrix Enterprise Groups,OU=Corporate Administration Groups,OU=Groups,OU=Business,OU=National,DC=corp,DC=ctv,DC=ca"

$GFile = New-Item -type file -force "D:\MyScripts\GroupDetails.csv"
Import-CSV "D:\MyScripts\GList.csv" | ForEach-Object {
$GName = $_.GroupName
$group = [ADSI] "LDAP://$GName"
$group.cn
$group.cn | Out-File $GFile -encoding ASCII -append
	foreach ($member in $group.member)
		{
			$Uname = new-object directoryservices.directoryentry("LDAP://$member")
			$Uname.cn
			$Uname.cn | Out-File $GFile -encoding ASCII -append
		}
}
