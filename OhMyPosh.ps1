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
#install theme adding the next to the file C:\Users\FTW3\OneDrive\Documentos\WindowsPowerShell\Microsoft.PowerShell_profile.ps1
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/cert.omp.json" | Invoke-Expression