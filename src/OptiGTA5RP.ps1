# OptiGTA5RP Advanced Optimizer
# Safe reversible GTA V / RAGE MP optimization

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

Info "Setting high performance power plan"
powercfg /setactive SCHEME_MIN

Info "Disabling Game DVR overhead"
reg add "HKCU\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v AppCaptureEnabled /t REG_DWORD /d 0 /f

Info "Optimizing GTA process priority"

$cfg = @"
Windows Registry Editor Version 5.00

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\GTA5.exe\PerfOptions]
"CPU Priority"=dword:00000003

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\ragemp_v.exe\PerfOptions]
"CPU Priority"=dword:00000003
"@

Set-Content "$Backup\priority.reg" $cfg

Info "Cleaning temporary cache"
Remove-Item "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue

Info "Done. Restart PC for maximum effect."
