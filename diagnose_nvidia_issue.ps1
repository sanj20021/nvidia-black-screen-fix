Write-Host "Diagnosing NVIDIA Black Screen Issue..." -ForegroundColor Cyan

$nvidiaCrashes = Get-WinEvent -FilterHashtable @{LogName='System'; ProviderName='nvlddmkm'; Id=13,153} -MaxEvents 5 -ErrorAction SilentlyContinue

if ($nvidiaCrashes) {
    Write-Host "`n[FOUND] Found NVIDIA Driver (nvlddmkm) crash events in the System Log!" -ForegroundColor Red
    Write-Host "This confirms your GPU driver is crashing when trying to wake up the display."
    Write-Host "Recent crash events:"
    $nvidiaCrashes | Select-Object TimeCreated, Id | Format-Table
} else {
    Write-Host "`n[CLEAN] No recent NVIDIA Driver crashes found in the System Log." -ForegroundColor Green
}

$monitorTimeout = powercfg /q | Select-String -Pattern "Turn off display after" -Context 0,2

Write-Host "`nCurrent Display Timeout Settings:" -ForegroundColor Yellow
$monitorTimeout | Out-String | Write-Host

Write-Host "If you have NVIDIA driver crashes and your PC stays awake (RGB on) but screen goes black, run fix_nvidia_black_screen.ps1." -ForegroundColor White

Write-Host "`nPress any key to exit..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
