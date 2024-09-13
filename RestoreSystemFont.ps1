$regPath = "HKCU:\Control Panel\Desktop\WindowMetrics"

# Set all appearance fonts to "Segoe UI" with size 9
Set-ItemProperty -Path $regPath -Name CaptionFont -Value "Segoe UI, 9"
Set-ItemProperty -Path $regPath -Name MenuFont -Value "Segoe UI, 9"
Set-ItemProperty -Path $regPath -Name MessageFont -Value "Segoe UI, 9"
Set-ItemProperty -Path $regPath -Name StatusFont -Value "Segoe UI, 9"
Set-ItemProperty -Path $regPath -Name IconFont -Value "Segoe UI, 9"

Write-Host "All appearance fonts have been set to Segoe UI."
