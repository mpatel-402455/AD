<#
.SYNOPSIS                                                                     
    Set AD user account expire date.
.DESCRIPTION                                                                  
    Set AD user account expire date. 
.NOTES                                                                        
    File Name      : Change-AccountExpireDate.ps1                                
    Author         :  https://github.com/mpatel-402455                
    Script Version : 1.0                                                      
    Last Modified  : November 11, 2016                                           
    Prerequisite   : PowerShell 
    Copyright      : https://github.com/mpatel-402455                                             
    
#>


$date = Get-Date -UFormat %Y-%m-%d-%H%M%S
$date
# Get-ADUser -Identity mpatel_test -Properties * | Select-Object -Property samaccountname,Emailaddress, AccountExpirationDate
#Get-ADUser -Filter {Emailaddress -eq "something@domain.com"}

#$EmailIDs = (Import-Csv -Path "C:\MyScripts\List-PushONEIDUser_Expiration.csv").email
$EmailIDs = (Import-Csv -Path "C:\MyScripts\TestUsersManishPatel.csv").email

foreach ($EmailID in $EmailIDs)
    {
        $PROPS = @{
                    #Write-Host "email ID: $EmailID" -ForegroundColor Cyan
                    'SamAccountName' = (Get-ADUser -Filter {Emailaddress -eq $EmailID} -Properties * | Select-Object -Property samaccountname).samaccountname
                    'Emailaddress' = (Get-ADUser -Filter {Emailaddress -eq $EmailID} -Properties * | Select-Object -Property Emailaddress).Emailaddress
                    'OldAccountExpirationDate' = (Get-ADUser -Filter {Emailaddress -eq $EmailID} -Properties * | Select-Object -Property AccountExpirationDate).AccountExpirationDate
                    'ChangeExpDate' = (Get-aduser -Filter {Emailaddress -eq $EmailID} -Properties * | Set-ADAccountExpiration -DateTime '12/31/2017 23:59:59')
                    'NewAccountExpirationDate' = (Get-ADUser -Filter {Emailaddress -eq $EmailID} -Properties * | Select-Object -Property AccountExpirationDate).AccountExpirationDate
                  } 
                    
             $Obj = New-Object -TypeName psobject -Property $PROPS
             Write-Output $Obj | Select-Object -Property 'SamAccountName','Emailaddress','OldAccountExpirationDate','NewAccountExpirationDate' `
             | Export-Csv -Path "C:\MyScripts\TAD-AccountExpireDate-INC000000437967-$date.csv" -Append       
    }
