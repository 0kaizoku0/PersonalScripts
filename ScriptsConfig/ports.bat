netsh advfirewall firewall add rule name="uTorrent TCP 45483" ^
dir=in action=allow protocol=TCP localport=45483
netsh advfirewall firewall add rule name="uTorrent UDP 45483" ^
dir=in action=allow protocol=UDP localport=45483

netsh advfirewall firewall show rule name=all | findstr 45483

netstat -ano | findstr 45483
