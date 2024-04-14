# To run ps1 with error:
# .ps1 cannot be loaded because running scripts is disabled on this system. For more information, see about_Execution_Policies at
# https:/go.microsoft.com/fwlink/?LinkID=135170.
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope LocalMachine
Get-ExecutionPolicy -List

# win11-taskbar-settings.ps1
New-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarAl" -Value 0 -Force
# Hide windows search bar
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search -Name SearchBoxTaskbarMode -Value 0 -Type DWord -Force
# Hide Task view
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name 'ShowTaskViewButton' -Type 'DWord' -Value 0 


# Make sure you update winget in microsoft store and login
# You can get App Installer from the Microsoft Store. If it's already installed, make sure it is updated with the latest version.
# https://www.microsoft.com/p/app-installer/9nblggh4nns1#activetab=pivot:overviewtab

# winget install --scope machine -e --id software
# winget install -e --id software

# Check for updates
winget update

# Update all
winget upgrade --all 


# Sticky Password
winget install --scope machine -e --id LamantineSoftware.StickyPassword
# winget install -e --id LamantineSoftware.StickyPassword
# winget install --id=LamantineSoftware.StickyPassword -e

# Firefox
winget install --scope machine -e --id Mozilla.Firefox
# winget install -e --id software Mozilla.Firefox

# Chrome
winget install --scope machine -e --id Google.Chrome
# winget install -e --id software Google.Chrome


# Notepad++
winget install --scope machine Notepad++.Notepad++
# winget install -e --id Notepad++.Notepad++

# PowerToys
winget install --scope machine Microsoft.PowerToys -s winget
# winget install Microsoft.PowerToys -s winget

# AIMP
winget install --scope machine -e --id AIMP.AIMP -v 5.03.2398
# winget install -e --id AIMP.AIMP

# WinRar
winget install --scope machine -e --id RARLab.WinRAR
# winget install -e --id RARLab.WinRAR
Write-Host "Install license" -ForegroundColor Yellow

# PowerISO
winget install --scope machine -e --id PowerSoftware.PowerISO
# winget install -e --id PowerSoftware.PowerISO
Write-Host "Install license" -ForegroundColor Yellow
Write-Host "Florencia Risuleo"
Write-Host "QFMC5-RVWI5-Q99TC-QD9QI-BI966"

# iTunes
winget install --scope machine -e --id Apple.iTunes -v 12.12.6.1
# winget install --scope machine -e --id Apple.iTunes
# winget install -e --id Apple.iTunes

# Piriform.CCleaner
winget install --scope machine -e --id Piriform.CCleaner

# PasswordSafe
winget install --scope machine -e --id RonyShapiro.PasswordSafe
# winget install -e --id RonyShapiro.PasswordSafe

# Internet Download Manager Fail in hash sometimes
winget install --scope machine -e --id Tonec.InternetDownloadManager
# winget install -e --id Tonec.InternetDownloadManager
Write-Host "Install license" -ForegroundColor Yellow
Write-Host "Jose" -ForegroundColor Yellow
Write-Host "Olvera" -ForegroundColor Yellow
Write-Host "armando.ob@hotmail.com" -ForegroundColor Yellow
Write-Host "bdgLq-ymr9y-5ykt7-qzqts" -ForegroundColor Yellow

# Whatsapp Outdated
#winget install --scope machine -e --id WhatsApp.WhatsApp
#winget install -e --id WhatsApp.WhatsApp
winget install -e --id 9NKSQGP7F2NH

# Core Temp
winget install --scope machine -e --id ALCPU.CoreTemp
# winget install -e --id ALCPU.CoreTemp

# Hard Disk Low Level Format Tool 
winget install --scope machine -e --id HDDGURU.HDDLLFTool
Write-Host "Install license" -ForegroundColor Yellow
Write-Host "4WKB-CLM6-8VV9-GQHG" -ForegroundColor Yellow

# CrystalDiskInfo
winget install --scope machine -e --id CrystalDewWorld.CrystalDiskInfo
# winget install -e --id CrystalDewWorld.CrystalDiskInfo

# Git
winget install --scope machine -e --id Git.Git
# winget install -e --id Git.Git

# Microsoft.VisualStudioCode -i=interactive
winget install --scope machine -e --id Microsoft.VisualStudioCode -i
# -i to add the context menu for open with code

# Logitech.GHUB
winget install --scope machine -e --id Logitech.GHUB
# winget install -e --id Logitech.GHUB

# DuongDieuPhap.ImageGlass
# winget install --scope machine -e --id DuongDieuPhap.ImageGlass
winget install --scope machine -e --id DuongDieuPhap.ImageGlass -v 8.7.10.26
winget upgrade DuongDieuPhap.ImageGlass
# winget install -e --id DuongDieuPhap.ImageGlass

# ShareX.ShareX
winget install --scope machine -e --id ShareX.ShareX
# winget install -e --id ShareX.ShareX
Write-Host "Import Settings" -ForegroundColor Yellow
Write-Host "C:\Users\FTW3\OneDrive\Archivos\Backup Config\ShareX" -ForegroundColor Yellow

# VideoLAN.VLC
winget install --scope machine -e --id VideoLAN.VLC
# winget install -e --id VideoLAN.VLC

# Windscribe.Windscribe
winget install -e --id Windscribe.Windscribe
# winget install --scope machine -e --id Windscribe.Windscribe
# winget install --scope machine -e --id Windscribe.Windscribe -v 2.9.9
# winget install --scope machine -e --id Windscribe.Windscribe -v 2.5.18
# winget install --scope machine -e --id Windscribe.Windscribe -v 2.4.11

# VMware.WorkstationPro
winget install -e --id VMware.WorkstationPro
# winget install --scope machine -e --id VMware.WorkstationPro -v 17.0.0
# winget install -e --id VMware.WorkstationPro -v 17.0.0
# winget install -e --id VMware.WorkstationPro -v 17.0.0
Write-Host "Install License" -ForegroundColor Yellow
Write-Host "AV1DR-DMGE6-M802P-D7ZEX-WV0TA" -ForegroundColor Green

# VMware.WorkstationPro
Write-Host "Trying to install"
winget install --scope machine -e --id VMware.WorkstationPro -v 17.0.0
# winget install -e --id VMware.WorkstationPro -v 17.0.0
Write-Host "Install License" -ForegroundColor Yellow
Write-Host "AV1DR-DMGE6-M802P-D7ZEX-WV0TA" -ForegroundColor Green

# PunkLabs.RocketDock Fail hash
winget install --scope machine -e --id PunkLabs.RocketDock
# winget install -e --id PunkLabs.RocketDock

# Sandboxie.Plus
winget install --scope machine -e --id Sandboxie.Plus
# winget install -e --id Sandboxie.Plus

# Ookla.Speedtest.CLI Command Alias in powershell speedtest
winget install --scope machine -e --id Ookla.Speedtest.CLI
winget install --scope machine -e --id Ookla.Speedtest.Desktop

# Valve.Steam
winget install --scope machine -e --id Valve.Steam

# EpicGames.EpicGamesLauncher
winget install --scope machine -e --id EpicGames.EpicGamesLauncher

# ElectronicArts.EADesktop hash fail
winget install --scope machine -e --id ElectronicArts.EADesktop

# MediaArea.MediaInfo.GUI
winget install --scope machine -e --id MediaArea.MediaInfo.GUI

# Audacity.Audacity
winget install --scope machine -e --id Audacity.Audacity

#winget install --id=Microsoft.DotNet.SDK.6 -e
winget install -e --id Microsoft.DotNet.SDK.6
#winget install --scope machine -e --id Microsoft.DotNet.SDK.6

# Microsoft.DotNet.Runtime.6
winget install -e --id Microsoft.DotNet.Runtime.6

# Microsoft Office
# winget install -e --id Microsoft.Office

# HandBrake.HandBrake
winget install --scope machine -e --id HandBrake.HandBrake

# OBSProject.OBSStudio
winget install --scope machine -e --id OBSProject.OBSStudio

# Nvidia.Broadcast
winget install --scope machine -e --id Nvidia.Broadcast

# CodecGuide.K-LiteCodecPack.Mega
winget install --scope machine -e --id CodecGuide.K-LiteCodecPack.Mega

# FastStone.Viewer Not installable
winget install -e --id FastStone.Viewer

# emoacht.Monitorian
winget install --scope machine -e --id emoacht.Monitorian

#Dolby Access
winget install "9N0866FS04W8" -s msstore

# Autodesk.EAGLE 9.6.2
winget install --scope machine -e --id Autodesk.EAGLE

# RealVNC.VNCViewer
winget install --scope machine -e --id RealVNC.VNCViewer

# RealVNC.VNCServer
winget install -e --id RealVNC.VNCServer

# KDE.Krita
winget install --scope machine -e --id KDE.Krita

# TeXstudio.TeXstudio
winget install --scope machine -e --id TeXstudio.TeXstudio

#####################################################
# AndroidStudio
winget install --scope machine -e --id Google.AndroidStudio -i

# Easeware.DriverEasy #tentative
winget install --scope machine -e --id Easeware.DriverEasy #tentative

# YairAichenbaum.Files #explorador de archivos prometedor
winget install --scope machine -e --id YairAichenbaum.Files #explorador de archivos prometedor

# FlorianHoech.DisplayCAL Calibrar monitor
winget install --scope machine -e --id FlorianHoech.DisplayCAL

# den4b.ReNamer Renombrar archivos
winget install --scope machine -e --id den4b.ReNamer #se ve bien para renombrar archivos

# AIDA64 Extreme 
winget install --scope machine -e --id FinalWire.AIDA64.Extreme
# winget install -e --id FinalWire.AIDA64.Extreme
Write-Host "Install license" -ForegroundColor Yellow


# rocksdanister.LivelyWallpaper
# winget install --scope machine -e --id rocksdanister.LivelyWallpaper

# Lively Wallpaper Metro
# winget install -e --id 9NKKGGS3VX8G
