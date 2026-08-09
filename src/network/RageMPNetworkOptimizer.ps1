# OptiGTA5RP Network Optimizer
# System-only tweaks for RAGE MP
# Does not modify GTA V files

Write-Host '[OptiGTA5RP] Network optimization started'

# Disable Windows autotuning issues on some systems
netsh interface tcp set global autotuninglevel=normal

# Enable TCP timestamps for modern networks
netsh interface tcp set global timestamps=enabled

# Flush DNS cache
ipconfig /flushdns

Write-Host '[OptiGTA5RP] Network optimization completed'
