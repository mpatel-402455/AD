$ServerNames = import-csv -path "C:\MyScripts\Win2K3\DecomServerList.csv"

foreach ($ServerName in $ServerNames)
    {
        "`n"
        $ServerName = $ServerName.HostName
        Write-Host $ServerName -ForegroundColor Yellow

        Remove-ADComputer $ServerName -Confirm:$false

        $results = Get-ADComputer $ServerName -ErrorAction SilentlyContinue
        
        if ($results -ne $NULL)
            {
                Write-Host "Failed to delete: $ServerName" -ForegroundColor Red
               $ServerName | Out-File -FilePath C:\MyScripts\Win2K3\RemoveFail.txt -Append
            }
    }


Get-ADComputer SrvDC001