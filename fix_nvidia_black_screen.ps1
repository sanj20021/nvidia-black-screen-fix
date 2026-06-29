Write-Host "Applying NVIDIA Black Screen Wake Fix..." -ForegroundColor Cyan

# 1. Disable PCIe Link State Power Management
Write-Host "1. Disabling PCIe Link State Power Management..."
powercfg /setacvalueindex SCHEME_CURRENT SUB_PCIEXPRESS ASPM 0
powercfg /setdcvalueindex SCHEME_CURRENT SUB_PCIEXPRESS ASPM 0

# 2. Disable Monitor Timeout
Write-Host "2. Disabling Display Turn Off timeout..."
powercfg /change monitor-timeout-ac 0
powercfg /change monitor-timeout-dc 0

# 3. Disable Hibernation Timeout
Write-Host "3. Disabling Auto-Hibernation..."
powercfg /change hibernate-timeout-ac 0
powercfg /change hibernate-timeout-dc 0

powercfg /setactive SCHEME_CURRENT

# 4. Enable Blank Screensaver (5 mins)
Write-Host "4. Enabling Blank Screensaver (5 minutes)..."
Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name ScreenSaveActive -Value "1"
Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name SCRNSAVE.EXE -Value "scrnsave.scr"
Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name ScreenSaveTimeOut -Value "300"
rundll32.exe user32.dll, UpdatePerUserSystemParameters

Write-Host "`nDone! The black screen wake bug should now be completely bypassed." -ForegroundColor Green
Write-Host "Press any key to exit..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
