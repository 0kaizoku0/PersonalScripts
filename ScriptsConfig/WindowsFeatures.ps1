﻿Write-Host "Probably is necessary run as Admin" -ForegroundColor Green
Write-Host "set-ExecutionPolicy RemoteSigned -Scope CurrentUser" -ForegroundColor Red
set-ExecutionPolicy RemoteSigned -Scope CurrentUser
Enable-WindowsOptionalFeature -Online -FeatureName NetFx3 -NoRestart
Enable-WindowsOptionalFeature -Online -FeatureName Printing-PrintToPDFServices-Features -NoRestart
Enable-WindowsOptionalFeature -Online -FeatureName NetFx4-AdvSrvs -NoRestart
Enable-WindowsOptionalFeature -Online -FeatureName NetFx4Extended-ASPNET45 -NoRestart
Enable-WindowsOptionalFeature -Online -FeatureName WCF-Services45 -NoRestart
Enable-WindowsOptionalFeature -Online -FeatureName WCF-HTTP-Activation45 -NoRestart
Enable-WindowsOptionalFeature -Online -FeatureName WCF-TCP-Activation45 -NoRestart
Enable-WindowsOptionalFeature -Online -FeatureName WCF-Pipe-Activation45 -NoRestart
Enable-WindowsOptionalFeature -Online -FeatureName WCF-MSMQ-Activation45 -NoRestart
Enable-WindowsOptionalFeature -Online -FeatureName WCF-TCP-PortSharing45 -NoRestart
Enable-WindowsOptionalFeature -Online -FeatureName IIS-WebServerRole -NoRestart
Enable-WindowsOptionalFeature -Online -FeatureName IIS-WebServer -NoRestart
Enable-WindowsOptionalFeature -Online -FeatureName IIS-CommonHttpFeatures -NoRestart
Enable-WindowsOptionalFeature -Online -FeatureName IIS-ApplicationDevelopment -NoRestart
Enable-WindowsOptionalFeature -Online -FeatureName IIS-Security -NoRestart
Enable-WindowsOptionalFeature -Online -FeatureName IIS-RequestFiltering -NoRestart
Enable-WindowsOptionalFeature -Online -FeatureName IIS-NetFxExtensibility -NoRestart
Enable-WindowsOptionalFeature -Online -FeatureName IIS-NetFxExtensibility45 -NoRestart
#Enable-WindowsOptionalFeature -Online -FeatureName WAS-WindowsActivationService -NoRestart
#Enable-WindowsOptionalFeature -Online -FeatureName WAS-ProcessModel -NoRestart
#Enable-WindowsOptionalFeature -Online -FeatureName WAS-NetFxEnvironment -NoRestart
#Enable-WindowsOptionalFeature -Online -FeatureName WAS-ConfigurationAPI -NoRestart
Enable-WindowsOptionalFeature -Online -FeatureName WCF-HTTP-Activation -NoRestart
Enable-WindowsOptionalFeature -Online -FeatureName WCF-NonHTTP-Activation -NoRestart
Enable-WindowsOptionalFeature -Online -FeatureName IIS-DefaultDocument -NoRestart
Enable-WindowsOptionalFeature -Online -FeatureName IIS-ISAPIFilter -NoRestart
Enable-WindowsOptionalFeature -Online -FeatureName IIS-ISAPIExtensions -NoRestart
Enable-WindowsOptionalFeature -Online -FeatureName IIS-ASPNET45 -NoRestart
Enable-WindowsOptionalFeature -Online -FeatureName MSMQ-Container -NoRestart
Enable-WindowsOptionalFeature -Online -FeatureName MSMQ-Server -NoRestart
#Enable-WindowsOptionalFeature -Online -FeatureName NetFx3 -NoRestart
Enable-WindowsOptionalFeature -Online -FeatureName MediaPlayback -NoRestart
Enable-WindowsOptionalFeature -Online -FeatureName WindowsMediaPlayer -NoRestart
Enable-WindowsOptionalFeature -Online -FeatureName SmbDirect -NoRestart
Enable-WindowsOptionalFeature -Online -FeatureName Printing-Foundation-Features -NoRestart
Enable-WindowsOptionalFeature -Online -FeatureName Printing-Foundation-InternetPrinting-Client -NoRestart
Enable-WindowsOptionalFeature -Online -FeatureName SMB1Protocol -NoRestart
Enable-WindowsOptionalFeature -Online -FeatureName SMB1Protocol-Client -NoRestart
Enable-WindowsOptionalFeature -Online -FeatureName SMB1Protocol-Server -NoRestart
Enable-WindowsOptionalFeature -Online -FeatureName SearchEngine-Client-Package -NoRestart
Enable-WindowsOptionalFeature -Online -FeatureName WorkFolders-Client -NoRestart
Enable-WindowsOptionalFeature -Online -FeatureName HypervisorPlatform -NoRestart
Enable-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform -NoRestart
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux -NoRestart
