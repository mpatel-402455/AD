<#
.SYNOPSIS                                                                     
    Get list of based on users Company name filed in Active Directory account.
.DESCRIPTION                                             
    Get list of based on users Company name filed in Active Directory account.
.NOTES
    File Name      : "Update-UsersCompanyName.ps1"
    Author         :  https://github.com/mpatel-402455
    Script Version : 1.0
    Last Modified  : October 26, 2016
    Prerequisite   : PowerShell
    Copyright      :  https://github.com/mpatel-402455
    
#>

#Set-ADUser mpatl_test -Replace @{company="MyCompanyName"}
#Get-ADUser -Filter {Company -eq 'Community Health Centre'} -Properties * | Select-Object -Property SamAccountName,Displayname,mail,physicalDeliveryOfficeName,Company | Export-Csv -Path "C:\tmp\users-.csv"


$OldName = "manish patel test"
$NewName = "Port Hope Community Health Centre"

$UserS = (Get-ADUser -Filter {Company -eq $OldName} -Properties *).SamAccountName

foreach ($User in $UserS)
    {
       Set-ADUser $User -Replace @{company="$NewName";physicalDeliveryOfficeName="$NewName"}
       Write-Host "The username is: $User" -ForegroundColor Cyan
    }