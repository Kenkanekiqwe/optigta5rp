# OptiGTA5RP Windows optimizer
# Run as Administrator

Write-Host 'OptiGTA5RP optimizer started'

$backup = "$env:USERPROFILE\Desktop\OptiGTA5RP_Backup"
New-Item -ItemType Directory -Force -Path $backup | Out-Null

# Power settings
powercfg /setactive SCHEME_MIN

# Disable Xbox background capture
New-ItemProperty -Path 'HKCU:\System\GameConfigStore' -Name 'GameDVR_Enabled' -Value 0 -PropertyType DWORD -Force | Out-Null
New-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR' -Name 'AppCaptureEnabled' -Value 0 -PropertyType DWORD -Force | Out-Null

# Network latency tweaks
New-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters' -Name 'Tcp1323Opts' -Value 1 -PropertyType DWORD -Force | Out-Null

# Clear temporary files
Remove-Item "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue

Write-Host 'Optimization complete. Restart PC for full effect.'
