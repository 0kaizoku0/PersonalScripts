# Get a list of enabled features
# Get-WindowsOptionalFeature -Online
Write-Host "Probably is necessary run as Admin" -ForegroundColor Green
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


FeatureName : Windows-Defender-Default-Definitions
State       : Enabled

FeatureName : Printing-PrintToPDFServices-Features
State       : Enabled

FeatureName : Printing-XPSServices-Features
State       : Disabled

FeatureName : TelnetClient
State       : Disabled

FeatureName : TIFFIFilter
State       : Disabled

FeatureName : LegacyComponents
State       : Disabled

FeatureName : DirectPlay
State       : Disabled

FeatureName : MSRDC-Infrastructure
State       : Enabled

FeatureName : Windows-Identity-Foundation
State       : Disabled

FeatureName : MicrosoftWindowsPowerShellV2Root
State       : Enabled

FeatureName : MicrosoftWindowsPowerShellV2
State       : Enabled

FeatureName : SimpleTCP
State       : Disabled

FeatureName : NetFx4-AdvSrvs
State       : Enabled

FeatureName : NetFx4Extended-ASPNET45
State       : Enabled

FeatureName : WCF-Services45
State       : Enabled

FeatureName : WCF-HTTP-Activation45
State       : Disabled

FeatureName : WCF-TCP-Activation45
State       : Disabled

FeatureName : WCF-Pipe-Activation45
State       : Disabled

FeatureName : WCF-MSMQ-Activation45
State       : Disabled

FeatureName : WCF-TCP-PortSharing45
State       : Enabled

FeatureName : IIS-WebServerRole
State       : Enabled

FeatureName : IIS-WebServer
State       : Enabled

FeatureName : IIS-CommonHttpFeatures
State       : Disabled

FeatureName : IIS-HttpErrors
State       : Disabled

FeatureName : IIS-HttpRedirect
State       : Disabled

FeatureName : IIS-ApplicationDevelopment
State       : Enabled

FeatureName : IIS-Security
State       : Enabled

FeatureName : IIS-RequestFiltering
State       : Enabled

FeatureName : IIS-NetFxExtensibility
State       : Enabled

FeatureName : IIS-NetFxExtensibility45
State       : Disabled

FeatureName : IIS-HealthAndDiagnostics
State       : Disabled

FeatureName : IIS-HttpLogging
State       : Disabled

FeatureName : IIS-LoggingLibraries
State       : Disabled

FeatureName : IIS-RequestMonitor
State       : Disabled

FeatureName : IIS-HttpTracing
State       : Disabled

FeatureName : IIS-URLAuthorization
State       : Disabled

FeatureName : IIS-IPSecurity
State       : Disabled

FeatureName : IIS-Performance
State       : Disabled

FeatureName : IIS-HttpCompressionDynamic
State       : Disabled

FeatureName : IIS-WebServerManagementTools
State       : Disabled

FeatureName : IIS-ManagementScriptingTools
State       : Disabled

FeatureName : IIS-IIS6ManagementCompatibility
State       : Disabled

FeatureName : IIS-Metabase
State       : Disabled

FeatureName : WAS-WindowsActivationService
State       : Enabled

FeatureName : WAS-ProcessModel
State       : Enabled

FeatureName : WAS-NetFxEnvironment
State       : Enabled

FeatureName : WAS-ConfigurationAPI
State       : Enabled

FeatureName : IIS-HostableWebCore
State       : Disabled

FeatureName : WCF-HTTP-Activation
State       : Enabled

FeatureName : WCF-NonHTTP-Activation
State       : Enabled

FeatureName : IIS-StaticContent
State       : Disabled

FeatureName : IIS-DefaultDocument
State       : Disabled

FeatureName : IIS-DirectoryBrowsing
State       : Disabled

FeatureName : IIS-WebDAV
State       : Disabled

FeatureName : IIS-WebSockets
State       : Disabled

FeatureName : IIS-ApplicationInit
State       : Disabled

FeatureName : IIS-ISAPIFilter
State       : Disabled

FeatureName : IIS-ISAPIExtensions
State       : Disabled

FeatureName : IIS-ASPNET
State       : Disabled

FeatureName : IIS-ASPNET45
State       : Disabled

FeatureName : IIS-ASP
State       : Disabled

FeatureName : IIS-CGI
State       : Disabled

FeatureName : IIS-ServerSideIncludes
State       : Disabled

FeatureName : IIS-CustomLogging
State       : Disabled

FeatureName : IIS-BasicAuthentication
State       : Disabled

FeatureName : IIS-HttpCompressionStatic
State       : Disabled

FeatureName : IIS-ManagementConsole
State       : Disabled

FeatureName : IIS-ManagementService
State       : Disabled

FeatureName : IIS-WMICompatibility
State       : Disabled

FeatureName : IIS-LegacyScripts
State       : Disabled

FeatureName : IIS-LegacySnapIn
State       : Disabled

FeatureName : IIS-FTPServer
State       : Disabled

FeatureName : IIS-FTPSvc
State       : Disabled

FeatureName : IIS-FTPExtensibility
State       : Disabled

FeatureName : MSMQ-Container
State       : Disabled

FeatureName : MSMQ-DCOMProxy
State       : Disabled

FeatureName : MSMQ-Server
State       : Disabled

FeatureName : MSMQ-ADIntegration
State       : Disabled

FeatureName : MSMQ-HTTP
State       : Disabled

FeatureName : MSMQ-Multicast
State       : Disabled

FeatureName : MSMQ-Triggers
State       : Disabled

FeatureName : IIS-CertProvider
State       : Disabled

FeatureName : IIS-WindowsAuthentication
State       : Disabled

FeatureName : IIS-DigestAuthentication
State       : Disabled

FeatureName : IIS-ClientCertificateMappingAuthentication
State       : Disabled

FeatureName : IIS-IISCertificateMappingAuthentication
State       : Disabled

FeatureName : IIS-ODBCLogging
State       : Disabled

FeatureName : NetFx3
State       : Enabled

FeatureName : SMB1Protocol-Deprecation
State       : Disabled

FeatureName : MediaPlayback
State       : Enabled

FeatureName : WindowsMediaPlayer
State       : Enabled

FeatureName : HostGuardian
State       : Disabled

FeatureName : Printing-Foundation-Features
State       : Enabled

FeatureName : Printing-Foundation-InternetPrinting-Client
State       : Enabled

FeatureName : Printing-Foundation-LPDPrintService
State       : Disabled

FeatureName : Printing-Foundation-LPRPortMonitor
State       : Disabled

FeatureName : DataCenterBridging
State       : Disabled

FeatureName : ServicesForNFS-ClientOnly
State       : Disabled

FeatureName : ClientForNFS-Infrastructure
State       : Disabled

FeatureName : NFS-Administration
State       : Disabled

FeatureName : SmbDirect
State       : Enabled

FeatureName : TFTP
State       : Disabled

FeatureName : WorkFolders-Client
State       : Enabled

FeatureName : Client-DeviceLockdown
State       : Disabled

FeatureName : Client-EmbeddedShellLauncher
State       : Disabled

FeatureName : Client-EmbeddedBootExp
State       : Disabled

FeatureName : Client-EmbeddedLogon
State       : Disabled

FeatureName : Client-KeyboardFilter
State       : Disabled

FeatureName : Client-UnifiedWriteFilter
State       : Disabled

FeatureName : AppServerClient
State       : Disabled

FeatureName : SearchEngine-Client-Package
State       : Enabled

FeatureName : HypervisorPlatform
State       : Disabled

FeatureName : VirtualMachinePlatform
State       : Disabled

FeatureName : Microsoft-Windows-Subsystem-Linux
State       : Disabled

FeatureName : Client-ProjFS
State       : Disabled

FeatureName : Containers-DisposableClientVM
State       : Disabled

FeatureName : Microsoft-Hyper-V-All
State       : Disabled

FeatureName : Microsoft-Hyper-V
State       : Disabled

FeatureName : Microsoft-Hyper-V-Tools-All
State       : Disabled

FeatureName : Microsoft-Hyper-V-Management-PowerShell
State       : Disabled

FeatureName : Microsoft-Hyper-V-Hypervisor
State       : Disabled

FeatureName : Microsoft-Hyper-V-Services
State       : Disabled

FeatureName : Microsoft-Hyper-V-Management-Clients
State       : Disabled

FeatureName : DirectoryServices-ADAM-Client
State       : Disabled

FeatureName : Windows-Defender-ApplicationGuard
State       : Disabled

FeatureName : Containers
State       : Disabled

FeatureName : Containers-HNS
State       : Disabled

FeatureName : Containers-SDN
State       : Disabled

FeatureName : SMB1Protocol
State       : Enabled

FeatureName : SMB1Protocol-Client
State       : Enabled

FeatureName : SMB1Protocol-Server
State       : Enabled

FeatureName : MultiPoint-Connector
State       : Disabled

FeatureName : MultiPoint-Connector-Services
State       : Disabled

FeatureName : MultiPoint-Tools
State       : Disabled