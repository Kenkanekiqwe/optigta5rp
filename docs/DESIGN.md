# OptiGTA5RP Design Rules

## File safety

OptiGTA5RP does NOT modify:
- GTA V settings.xml
- graphics.xml
- gameconfig.xml
- RAGE MP client assets
- server files

## Optimization targets

Only system-level changes:
- Windows scheduler
- power management
- background processes
- GPU driver settings profiles
- network latency settings
- RAM cleanup
- CPU priority

All changes must have:
- backup
- rollback option
- safe mode
