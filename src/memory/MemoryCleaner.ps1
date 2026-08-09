# OptiGTA5RP Memory Helper
# Safe Windows cleanup

Write-Host '[OptiGTA5RP] Cleaning temporary memory load'

Remove-Item "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "$env:LOCALAPPDATA\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue

[System.GC]::Collect()

Write-Host '[OptiGTA5RP] Memory cleanup finished'
