# Function to decode the font name and size from the registry
function Get-FontDetails {
  param (
      [Parameter(Mandatory=$true)]
      [byte[]]$binaryFont
  )
  
  # Convert the byte array into a string, skipping the initial metadata bytes
  $fontName = [System.Text.Encoding]::Default.GetString($binaryFont[2..($binaryFont.Length-1)]).Trim("`0")

  # Extract the font size (stored in the first two bytes, little-endian format)
  $fontSizeBytes = [System.BitConverter]::ToInt16($binaryFont, 0)
  $fontSize = [math]::abs($fontSizeBytes) / 10  # Divide by 10 to get correct size

  # Adjust if font size seems too small (apply scaling factor)
  if ($fontSize -lt 2) {
      $fontSize = $fontSize * 5  # Adjust scaling factor
  }

  return [pscustomobject]@{
      FontName = $fontName
      FontSize = $fontSize
  }
}

# Get the fonts from the registry
$regPath = "HKCU:\Control Panel\Desktop\WindowMetrics"
$fonts = Get-ItemProperty -Path $regPath

# Get font details for each element
$captionFont = Get-FontDetails $fonts.CaptionFont
$menuFont = Get-FontDetails $fonts.MenuFont
$messageFont = Get-FontDetails $fonts.MessageFont
$statusFont = Get-FontDetails $fonts.StatusFont
$iconFont = Get-FontDetails $fonts.IconFont

# Display the results
Write-Host "Caption Font:  $($captionFont.FontName), Size: $($captionFont.FontSize)"
Write-Host "Menu Font:     $($menuFont.FontName), Size: $($menuFont.FontSize)"
Write-Host "Message Font:  $($messageFont.FontName), Size: $($messageFont.FontSize)"
Write-Host "Status Font:   $($statusFont.FontName), Size: $($statusFont.FontSize)"
Write-Host "Icon Font:     $($iconFont.FontName), Size: $($iconFont.FontSize)"
