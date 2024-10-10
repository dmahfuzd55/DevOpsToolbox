<h2 align="center">
Windows Subsystem for Linux Command and Usage Documentation
</h2>


#### Local machine bind to WSL machine

```bash
netsh interface portproxy add v4tov4 listenport=8080 listenaddress=0.0.0.0 connectport=8080 connectaddress=172.27.11.212
```