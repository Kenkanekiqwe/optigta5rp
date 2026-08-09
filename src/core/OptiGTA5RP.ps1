# OptiGTA5RP Core Optimizer
# System-only optimization for GTA V / RAGE MP
# Does NOT modify GTA settings.xml or game files

$Backup = "$env:USERPROFILE\Desktop\OptiGTA5RP_Backup"

function Create-Backup {
    New-Item -ItemType Directory -Force -Path $Backup | Out-Null
}

function Enable-PerformanceMode {
    Write-Host '[+] Enabling High Performance power plan'
    powercfg /setactive SCHEME_MIN
}

function Optimize-WindowsGaming {
    Write-Host '[+] Applying Windows gaming optimizations'

    # Disable Xbox Game DVR background recording
    reg add "HKCU\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 0 /f | Out-Null
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v AppCaptureEnabled /t REG_DWORD /d 0 /f | Out-Null

    # Enable hardware accelerated GPU scheduling preference (Windows controls availability)
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v HwSchMode /t REG_DWORD /d 2 /f | Out-Null
}

function Optimize-Network {
    Write-Host '[+] Applying network latency tweaks'

    netsh int tcp set global autotuninglevel=normal | Out-Null
    netsh int tcp set global rss=enabled | Out-Null
    netsh int tcp set global timestamps=disabled | Out-Null
}

function Optimize-Processes {
    Write-Host '[+] Optimizing GTA/RAGE MP process priority'

    Get-Process GTA5,rage-mp,RAGE* -ErrorAction SilentlyContinue | ForEach-Object {
        try {
            $_.PriorityClass = 'High'
        } catch {}
    }
}

function Clean-TemporaryCache {
    Write-Host '[+] Cleaning temporary system cache'

    Remove-Item "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue
}

Create-Backup
Enable-PerformanceMode
Optimize-WindowsGaming
Optimize-Network
Optimize-Processes
Clean-TemporaryCache

Write-Host '[DONE] System optimization completed. GTA files were not modified.'
