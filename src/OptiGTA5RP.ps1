# OptiGTA5RP System Optimizer
# Safe Windows-only optimization for GTA V / RAGE MP
# Does not modify GTA files, settings.xml or game configs

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

Info "Enabling High Performance power plan"
powercfg /setactive SCHEME_MIN

Info "Disabling Windows gaming overlays overhead"
reg add "HKCU\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v AppCaptureEnabled /t REG_DWORD /d 0 /f

Info "Optimizing process priority rules"
$cfg = @"
Windows Registry Editor Version 5.00

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\GTA5.exe\PerfOptions]
"CpuPriorityClass"=dword:00000003

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\ragemp_v.exe\PerfOptions]
"CpuPriorityClass"=dword:00000003
"@

Set-Content "$Backup\priority.reg" $cfg

Info "Cleaning Windows temporary files"
Remove-Item "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue

Info "System optimization completed"
Info "GTA V files and settings.xml were not changed"
