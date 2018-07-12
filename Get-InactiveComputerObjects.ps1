#Get-ADComputer -Identity tormanishpd01 -Properties *

#$a = (Get-ADComputer -SearchBase "OU=Servers,"OU=Infrastructure,OU=prod,DC=myLab,DC=local" -Filter * -Properties * | Format-Table Name,OperatingSystem,PasswordLastSet,LastLogonDate -AutoSize)

#$b = (Get-ADComputer -SearchBase "OU=prod,DC=myLab,DC=local" -Filter 'OperatingSystem -like "*Windows Server*"' -Properties * | Format-Table Name,OperatingSystem,PasswordLastSet,LastLogonDate -AutoSize)

#$C = (Get-ADComputer -SearchBase "OU=Infrastructure,OU=prod,DC=myLab,DC=local" -Filter * -Properties * | Format-Table Name,OperatingSystem,PasswordLastSet,LastLogonDate -AutoSize)

$date = [DateTime]::Today.AddDays(-122)
Get-ADComputer -SearchBase "OU=Infrastructure,OU=prod,DC=myLab,DC=local" -Filter {PasswordLastSet -lt $date} -Properties * |Select-Object Name,OperatingSystem,PasswordLastSet,LastLogonDate | Export-Csv "C:\temp\Inactive-servers-PS-list-2016-06-07.csv"

