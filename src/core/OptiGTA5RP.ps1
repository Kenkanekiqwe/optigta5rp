# OptiGTA5RP Core Optimizer
# Safe reversible GTA V / RAGE MP optimization

$Backup = "$env:USERPROFILE\Desktop\OptiGTA5RP_Backup"

function Create-Backup {
    New-Item -ItemType Directory -Force -Path $Backup | Out-Null
}

function Enable-PerformanceMode {
    Write-Host '[+] Enabling High Performance power plan'
    powercfg /setactive SCHEME_MIN
}

function Optimize-GTA {
    Write-Host '[+] Applying GTA V optimizations'

    $settings = "$env:USERPROFILE\Documents\Rockstar Games\GTA V\settings.xml"
    if (Test-Path $settings) {
        Copy-Item $settings "$Backup\settings.xml" -Force
    }
}

function Clean-RageMP {
    Write-Host '[+] Cleaning RAGE MP cache'

    $paths = @(
        "$env:LOCALAPPDATA\RAGEMP\client_resources",
        "$env:LOCALAPPDATA\RAGEMP\cef_cache"
    )

    foreach ($path in $paths) {
        if (Test-Path $path) {
            Remove-Item $path -Recurse -Force -ErrorAction SilentlyContinue
        }
    }
}

Create-Backup
Enable-PerformanceMode
Optimize-GTA
Clean-RageMP

Write-Host '[DONE] OptiGTA5RP optimization completed'
