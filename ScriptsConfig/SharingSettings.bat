:: To enable Network Discovery for all network profiles (Domain, Private, and Public), use the following command:
netsh advfirewall firewall set rule group="Network Discovery" new enable=Yes

:: To enable File and Printer Sharing for all network profiles (Domain, Private, and Public), use the following command:
netsh advfirewall firewall set rule group="File and Printer Sharing" new enable=Yes

:: To enable Public folder sharing for all network profiles (Domain, Private, and Public), use the following command:
netsh advfirewall firewall set rule group="Public Folder Sharing" new enable=No

:: Enable or Disable Password Protected Sharing in Windows 
:: Almost same as Run win+R → control userpasswords2
Net user guest *