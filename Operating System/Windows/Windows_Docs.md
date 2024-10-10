<h2 align="center">
Linux Command and Usage Documentation
</h2>

Multiple connections to a server or shared resource by the same user, using more than one user name, are not allowed
```bash
Get-Service workstation | Restart-Service -Force
```

Windows running port and kill
```bash
Get-NetTCPConnection | Where-Object {$_.State -eq "Listen"}

taskkill /PID <PID> /F
```