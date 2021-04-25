$root = Get-Location

Clear-Host

Write-Host -ForegroundColor Green "Loading required includes"
$includes = @("config.ps1", "database.ps1", "extra.ps1", "requirements.ps1", "source.ps1")
foreach ($include in $includes)
{
    if (Test-Path -Path includes\$include)
    {
        Write-Host -ForegroundColor Yellow "Loading $include"
        . includes\$include
    }
    else
    {
        Print-Error("Failed to load $include")
    }
}

if ($args.count -gt 0)
{
    if ($args.count -eq 2)
    {
        if (($args[0] -eq "all") -or ($args[0] -eq "auth") -or ($args[0] -eq "world"))
        {
            if (($args[1] -eq "install") -or ($args[1] -eq "setup") -or ($args[1] -eq "update"))
            {
                Download-Source
                Compile-Source
                Copy-Binaries $args[0]
                Download-Data $args[0]
            }
            elseif (($args[1] -eq "database") -or ($args[1] -eq "db"))
            {
            }
            elseif (($args[1] -eq "configuration") -or ($args[1] -eq "config") -or ($args[1] -eq "cfg"))
            {
                Update-Configuration $args[0]
            }
            elseif ($args[1] -eq "all")
            {
                Download-Source
                Compile-Source
                Copy-Binaries $args[0]
                Download-Data $args[0]
            }
        }
        else
        {
            Print-Error("The supplied parameters are invalid")
        }
    }
    else
    {
        Print-Error("The supplied parameters are invalid")
    }
}
else
{
    Print-Error("Missing required parameters")
}
