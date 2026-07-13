@echo off
:: Ensure administrative privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo CRITICAL ERROR: This script must be run as an Administrator.
    pause
    exit /b
)

:: ==========================================
:: CONFIGURATION VARIABLES
:: ==========================================
:: Set the exact name of your Ethernet adapter (check "ncpa.cpl")
set "ADAPTER_NAME=Ethernet"

:: Set your desired network configuration (Gateway omitted)
set "NEW_IP=192.168.1.150"
set "NEW_SUBNET=255.255.255.0"

:: 2. Change IP Address and Subnet Mask (Gateway parameter omitted)
echo [2/3] Configuring Static IP and Subnet Mask...
netsh interface ip set address name="%ADAPTER_NAME%" static %NEW_IP% %NEW_SUBNET% none >nul

:: 3. Restart the adapter to apply changes immediately
echo [3/3] Restarting adapter to apply the new MAC hardware address...
powershell -Command "Disable-NetAdapter -Name '%ADAPTER_NAME%' -Confirm:$false; Enable-NetAdapter -Name '%ADAPTER_NAME%'"

echo -----------------------------------------------------------
echo Configuration complete!
echo Current Details:
ipconfig /all | findstr /R /C:"Description" /C:"Physical Address" /C:"IPv4 Address" /C:"Subnet Mask" /C:"Default Gateway"
pause
