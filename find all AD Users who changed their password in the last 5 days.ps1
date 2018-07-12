# find all AD Users who changed their password in the last 5 days
$date = (Get-Date).AddDays(-5)
$ticks = $date.ToFileTime()


$ldap = "(&(objectCategory=person)(objectClass=user)(pwdLastSet>=$ticks))"
Get-ADUser -LDAPFilter $ldap -Properties * |
  Select-Object -Property Name, PasswordLastSet