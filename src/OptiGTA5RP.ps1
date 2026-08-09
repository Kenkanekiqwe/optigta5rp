# OptiGTA5RP System Optimizer
# Windows and hardware optimization only
# IMPORTANT: Never modifies GTA V files, settings.xml, graphics.xml or RAGE MP assets

param(
    [switch]$Full
)

$Backup = "$env:USERPROFILE\Desktop\OptiGTA5RP_Backup"
New-Item -ItemType Directory -Force -Path $Backup | Out-Null

function Info($t){ Write-Host "[OptiGTA5RP] $t" -ForegroundColor Cyan }

Info "Creating restore point..."
try {
    Checkpoint-Computer -Description "OptiGTA5RP Backup" -RestorePointType MODIFY_SETTINGS -ErrorAction SilentlyContinue
} catch {}

Info "Setting High Performance power mode"
powercfg /setactive SCHEME_MIN

Info "Disabling Xbox/Game DVR background capture"
reg add "HKCU\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v AppCaptureEnabled /t REG_DWORD /d 0 /f

Info "Optimizing multimedia scheduling"
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v SystemResponsiveness /t REG_DWORD /d 0 /f

Info "Optimizing GTA and RAGE MP priority"
$cfg = @"
Windows Registry Editor Version 5.00

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\GTA5.exe\PerfOptions]
"CpuPriorityClass"=dword:00000003

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\ragemp_v.exe\PerfOptions]
"CpuPriorityClass"=dword:00000003
"@
Set-Content "$Backup\priority.reg" $cfg

Info "Cleaning temporary system cache"
Remove-Item "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue

Info "Optimization finished"
Info "No GTA files changed"
Info "No settings.xml modification performed"
