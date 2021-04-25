Function Update-Configuration($type)
{
    Clear-Host
    Write-Host -ForegroundColor Green "Updating configuration files"

    if (($type -eq "auth") -or ($type -eq "all"))
    {
        if (Test-Path -Path "$root\bin\configs\authserver.conf.dist")
        {
            Write-Host -ForegroundColor Yellow "Updating authserver.conf"
            Copy-Item -Path "$root\bin\configs\authserver.conf.dist" -Destination "$root\bin\configs\authserver.conf" -Force

            if (-not $?)
            {
                cd $root
                Print-Error("Make sure to fix any errors listed above before trying again")
            }
        }
    }

    if (($type -eq "world") -or ($type -eq "all"))
    {
        if (Test-Path -Path "$root\bin\configs\worldserver.conf.dist")
        {
            Write-Host -ForegroundColor Yellow "Updating worldserver.conf"
            Copy-Item -Path "$root\bin\configs\worldserver.conf.dist" -Destination "$root\bin\configs\worldserver.conf" -Force

            if (-not $?)
            {
                cd $root
                Print-Error("Make sure to fix any errors listed above before trying again")
            }
        }
    }
}
