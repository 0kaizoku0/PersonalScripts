# BenchToolAMQRO
Tool for monitoring bench availability
It was mainly design for using with benches in QRO MX but can be modified for the list of benches you require.
## Confluence
Detailed instructions can be found here:
[Bench Tool](https://confluence.auto.continental.cloud/x/d0aEkg)
## Preconditions

**1. Enable PowerShell Remoting in local computer and remote benches.**

Open a Windows Powershell as Admin and write the next command:
```
  Enable-PSRemoting -Force
```

**2. Enable Remote Desktop on benches**
**3. Define a list with the next format:**
> Alias,ComputerName,User,Password
> - Alias:  the name you desire to identify the Bench.
> - ComputerName: Is the name assigned to the PC for network usage.
> - User: the user id to login into PC, need admin rights
> - Password: the Password used to login
> ```
>       Bench1,ComputerName1,user1,password1
>       Bench2,ComputerName2,user2,password2
>       Bench3,ComputerName3,user3,password3
>       Bench4,ComputerName4,user4,password4
> ```