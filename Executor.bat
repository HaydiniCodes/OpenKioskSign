@echo off
:: Path to the PowerShell script
set "ps1_script=C:\path\to\signage_script.ps1"

powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%ps1_script%"

pause

