# OptiGTA5RP Hardware Scanner
# Read-only. Does not modify GTA files.

function Get-SystemInfo {
    $cpu = Get-CimInstance Win32_Processor | Select-Object -First 1
    $gpu = Get-CimInstance Win32_VideoController | Select-Object -First 1
    $ram = Get-CimInstance Win32_ComputerSystem

    return [PSCustomObject]@{
        CPU = $cpu.Name
        Cores = $cpu.NumberOfCores
        Threads = $cpu.NumberOfLogicalProcessors
        GPU = $gpu.Name
        VRAM = $gpu.AdapterRAM
        RAMGB = [math]::Round($ram.TotalPhysicalMemory / 1GB)
        Windows = (Get-CimInstance Win32_OperatingSystem).Caption
    }
}

Get-SystemInfo
