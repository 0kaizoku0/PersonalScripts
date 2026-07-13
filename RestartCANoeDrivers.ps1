# 1. Busca las interfaces físicas (VN56) y descarta explícitamente el Enumerator
$devices = Get-PnpDevice | Where-Object { 
    $_.FriendlyName -like "*VN56*" -and 
    $_.FriendlyName -notlike "*Enumerator*" -and 
    $_.Status -eq "OK" 
}

if ($devices) {
    foreach ($dev in $devices) {
        Write-Host "Reiniciando hardware físico: $($dev.FriendlyName)..." -ForegroundColor Cyan
        
        # Desactivar la interfaz física
        Disable-PnpDevice -InstanceId $dev.InstanceId -Confirm:$false
        Start-Sleep -Seconds 2
        
        # Volver a activar
        Enable-PnpDevice -InstanceId $dev.InstanceId -Confirm:$false
        Write-Host "¡$($dev.FriendlyName) reiniciada con éxito!" -ForegroundColor Green
        Write-Host "-------------------------------------------"
    }
} else {
    Write-Host "No se encontraron interfaces físicas VN56xx activas." -ForegroundColor Red
}
