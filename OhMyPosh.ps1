winget install --scope machine -e --id JanDeDobbeleer.OhMyPosh -i
# POSH_THEMES_PATH → change the name befor .omp.json
# C:\Program Files (x86)\oh-my-posh\themes

oh-my-posh font install Inconsolata
oh-my-posh font install 0xProto

# Use Ctrl + Shift + , to open settings for fonts
# Search profiles and paste the next
<#
"profiles":
{
        "defaults": {
          "font":
         {
           // You can use any font removing comments
           // "face": "MesloLGM Nerd Font"
           // "face": "Inconsolata Nerd Font"
           "face": "0xProto Nerd Font"
         }
        },
}
#>

oh-my-posh init pwsh --config ~/jandedobbeleer.omp.json | Invoke-Expression
# Install theme adding the next to the file C:\Users\FTW3\OneDrive\Documentos\WindowsPowerShell\Microsoft.PowerShell_profile.ps1
# Minimal themes don't contain glyphs
# https://ohmyposh.dev/docs/themes

oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/onehalf.minimal.omp.json" | Invoke-Expression
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/peru.omp.json" | Invoke-Expression
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/pure.omp.json" | Invoke-Expression

notepad.exe $PROFILE

New-Item -Path $PROFILE -Type File -Force

. $PROFILE

Install-Module -Name Terminal-Icons -Repository PSGallery
#copy to profile
Import-Module Terminal-Icons

Set-PSReadLineOption -PredictionViewStyle ListView

# for cmd install clink
winget install --scope machine -e --id chrisant996.Clink

<# Custom tab name add into settings.json profile
{
  "profiles": {
    "list": [
      {
        "guid": "{unique-guid-for-powershell}",
        "name": "PowerShell",
        "commandline": "pwsh -NoExit -Command \"& { Set-Location ~; $Host.UI.RawUI.WindowTitle = (Get-Location).Path }\""
      }
    ]
  }
}

# Or use settingsBackup.json
#>

# Function to update the tab title
function Update-TabTitle {
    $Host.UI.RawUI.WindowTitle = Split-Path -Leaf (Get-Location)
}

# Override the prompt to use the Oh My Posh prompt and update the tab title
# function Prompt {
#     Update-TabTitle
# }
Update-TabTitle

<#
Error for restoring tabs from previous session
I'll summarize it for me to do it faster next time.

    Make sure your C:\Users\<user>\Documents\PowerShell\Microsoft.PowerShell_profile.ps1 profile contains a line like oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/unicorn.omp.json" | Invoke-Expression
    Use code $env:POSH_THEMES_PATH/unicorn.omp.json to open the file VS code (or any other editor)
    Modify the file as follows:

    {
      "$schema": "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/schema.json",
    + "pwd": "osc99",
      "blocks": [
        {
          "alignment": "left",
        ...

See also

    https://learn.microsoft.com/en-us/windows/terminal/tutorials/new-tab-same-directory
    https://ohmyposh.dev/docs/configuration/overview#general-settings - for pwd settings (osc99)
#>
