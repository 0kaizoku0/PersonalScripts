winget install --scope machine -e --id JanDeDobbeleer.OhMyPosh -i
# POSH_THEMES_PATH → change the name befor .omp.json
# C:\Program Files (x86)\oh-my-posh\themes

oh-my-posh font install Inconsolata
oh-my-posh font install 0xProto

# Use Ctrl + Shift + , to open settings for fonts
# Search profiles and paste the next
# "profiles":
# {
#     "defaults":
#     {
#         "font":
#         {
#           // You can use any font removing comments
#           // "face": "MesloLGM Nerd Font"
#           // "face": "Inconsolata Nerd Font"
#           "face": "0xProto Nerd Font"
#         }
#     }
# }

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
Import-Module Terminal-Icons

Set-PSReadLineOption -PredictionViewStyle ListView

# for cmd install clink
winget install --scope machine -e --id chrisant996.Clink