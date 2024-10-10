<h2 align="center">
Nginx Command and Usage Documentation
</h2>


## Centos

To configure Nginx on CentOS to serve a .NET Core project, you can follow these steps:

Install Nginx (if not already installed):
```bash
sudo yum update
sudo yum install nginx
```
Start and Enable Nginx:
```bash
sudo systemctl start nginx
sudo systemctl enable nginx
```
Create a Nginx Configuration File:

Create a new configuration file for your .NET Core project in the /etc/nginx/conf.d/ directory. You can name the file something like your_project.conf.
```bash
sudo nano /etc/nginx/conf.d/your_project.conf
```
Configure Nginx:

Inside the configuration file, you'll define a server block for your .NET Core project. Here's an example configuration assuming your .NET Core application is running on port 5000:
```bash
server {
    listen 80;
    server_name 172.8.9.41;

    location / {
        proxy_pass http://localhost:5000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection keep-alive;
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }
}
```
Replace your_domain.com with your actual domain name or server IP address.

Test Nginx Configuration:

Check for syntax errors in your Nginx configuration file:
```bash
sudo nginx -t
```
Reload Nginx:

If the configuration test is successful, reload Nginx to apply the changes:
```bash
sudo systemctl reload nginx
```