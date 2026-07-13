# Ensure administrative privileges
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Write-Host "CRITICAL ERROR: This script must be run as an Administrator."
    Pause
    exit 1
}

# ==========================================
# CONFIGURATION VARIABLES
# ==========================================
# Set the exact name of your Ethernet adapter (check "ncpa.cpl")
$AdapterName = "External"

# Set your desired network configuration (Gateway omitted)
$NewIP = "192.168.1.151"
$NewSubnet = "255.255.0.0"

# New MAC address (12 hex chars, no separators)
$NewMacAddress = "112233AABBCC"

if ($NewMacAddress -notmatch '^[0-9A-Fa-f]{12}$') {
    Write-Host "CRITICAL ERROR: New MAC must be exactly 12 hexadecimal characters (example: 001122AABBCC)."
    Pause
    exit 1
}

# 2. Change IP Address and Subnet Mask (Gateway parameter omitted)
Write-Host "Configuring Static IP and Subnet Mask..."
netsh interface ip set address name="$AdapterName" static $NewIP $NewSubnet none | Out-Null

# 3. Change MAC address
Write-Host "Applying new MAC address..."
try {
    # Many adapters expose locally administered MAC as the "NetworkAddress" advanced property.
    Set-NetAdapterAdvancedProperty -Name $AdapterName -RegistryKeyword "NetworkAddress" -RegistryValue $NewMacAddress -NoRestart -ErrorAction Stop
}
catch {
    Write-Host "CRITICAL ERROR: Failed to set MAC address on adapter '$AdapterName'."
    Write-Host "Details: $($_.Exception.Message)"
    Pause
    exit 1
}

# 4. Restart the adapter to apply changes immediately
Write-Host "Restarting adapter to apply the new MAC hardware address..."
Disable-NetAdapter -Name $AdapterName -Confirm:$false
Enable-NetAdapter -Name $AdapterName -Confirm:$false

Write-Host "-----------------------------------------------------------"
Write-Host "Configuration complete!"
Write-Host "Current Details:"
ipconfig /all | Select-String -Pattern "Description|Physical Address|IPv4 Address|Subnet Mask|Default Gateway"
Pause
