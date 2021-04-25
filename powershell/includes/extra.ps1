Function Print-Error($text)
{
    Write-Host -ForegroundColor Red "`nAn error has occured"
    Write-Host -ForegroundColor Yellow $text
    exit 1
}
