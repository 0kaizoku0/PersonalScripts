netsh advfirewall firewall add rule name="uTorrent TCP 45490" ^
dir=in action=allow protocol=TCP localport=45490
netsh advfirewall firewall add rule name="uTorrent UDP 45490" ^
dir=in action=allow protocol=UDP localport=45490

netsh advfirewall firewall show rule name=all | findstr 45490

netstat -ano | findstr 45490
