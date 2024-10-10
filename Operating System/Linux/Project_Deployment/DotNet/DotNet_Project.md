<h2 align="center">
DotNet Project Deployment Command and Usage Documentation
</h2>

### Install .NET Runtime:
If the .NET runtime is not already installed on Linux server, need to install it. can follow the official documentation for instructions specific to your Linux distribution: https://docs.microsoft.com/en-us/dotnet/core/install/linux


To install .NET Core 6.0 on CentOS 8, you can follow these steps:

Register Microsoft Product Repository:
First, you need to register the Microsoft product repository on your system. Run the following command to download and install the repository configuration package:
```bash
sudo rpm -Uvh https://packages.microsoft.com/config/rhel/8/packages-microsoft-prod.rpm
```
Install .NET SDK:


After registering the repository, update the package cache and install the .NET SDK:
```bash
sudo dnf update
sudo dnf install dotnet-sdk-6.0
This command installs the .NET SDK 6.0 package, which includes everything you need to build and run .NET Core applications.
```

Verify Installation:
Once the installation is complete, you can verify that the .NET SDK is installed correctly by running:
```bash
dotnet --version
```
This command should display the installed version of the .NET SDK.

Optional: Install ASP.NET Core Runtime:
If you only intend to run ASP.NET Core applications and don't need the SDK for development, you can install the ASP.NET Core Runtime:
```bash
sudo dnf install aspnetcore-runtime-6.0
```
Optional: Install ASP.NET Core Runtime for Hosting:
If you plan to host ASP.NET Core applications with a web server like Apache or Nginx, you can install the ASP.NET Core Runtime for Hosting:
```bash
sudo dnf install aspnetcore-runtime-6.0
```
Set Up Environment Variables (Optional):
Optionally, you can set up environment variables such as PATH to include the .NET command-line tools. This step makes it more convenient to run the tools without specifying the full path to the executable.
```bash
echo 'export PATH="$PATH:$HOME/.dotnet"' >> ~/.bashrc
source ~/.bashrc
```

#### Creating DotNet Project
Creating a .NET Core Web API project involves several steps. Here's a basic guide on how to create one:

Install .NET SDK: Ensure you have the .NET SDK installed on your machine. You can download it from the official .NET website if you haven't already.

Create a New Web API Project: Open a terminal or command prompt, navigate to the directory where you want to create your project, and run the following command:
```bash
dotnet new webapi -n MyWebApi
This command creates a new ASP.NET Core Web API project named MyWebApi.
```
Navigate to the Project Directory: Change into the newly created project directory:
```bash
cd MyWebApi
```
Run the Application: You can run the application using the following command:
```bash
dotnet run
This will start the Web API application, and you should see output indicating that the application is running.
```

Test the API: Once the application is running, you can test your API endpoints using tools like Postman or curl. By default, the template creates a WeatherForecast controller with a GET endpoint at /weatherforecast. You can send a GET request to https://localhost:5001/weatherforecast (assuming the default port) to test the endpoint.


#### Publish DotNet Application:
First, you need to publish your .NET Core application for deployment. Open a terminal or command prompt, navigate to the directory of your project, and run the following command:
```bash
dotnet publish -c Release

dotnet build -o D:\DotNet\Project_Deploy_Linux\Hello_Linux\Build_Output
```
This command compiles dotnet application and creates a folder containing the files needed to run application.

Transfer Files to Linux Server:
Once application is published, need to transfer the published files to Linux server. You can use various methods like FTP, SCP, or SFTP for file transfer. For example, using SCP:
```bash
scp -r /path/to/published/files username@your_server_ip:/path/to/destination

scp -r /d/DotNet/Project_Deploy_Linux/Hello_Linux/Build_Output/ root@103.134.89.153:/var/applications/hello_linux/
```
#### Run Application:
Navigate to the directory where you copied your published files and run your application:
```bash
cd /path/to/destination
dotnet YourAppName.dll
Replace YourAppName.dll with the name of your application's DLL file.

dotnet Hello_Linux.dll --urls=http://0.0.0.0:5000

dotnet GATEWAYDEMO.dll --urls=http://localhost:<new_port>
```

#### Run Application Continously(as a deamon or background service)

To run a .NET Core application continuously (i.e., as a daemon or background service), you typically need to use a process manager or a service manager, depending on your operating system.

If you're using a Linux distribution like Ubuntu, CentOS, or Debian, you can use systemd to manage your .NET Core application as a service. Here's a general outline of how to set it up:

Create a systemd Service Unit File:
Create a systemd service unit file (e.g., hello-linux.service) in the /etc/systemd/system/ directory. Here's an example of what the file might look like:
```bash
[Unit]
Description=gatewaydemo .NET Core Application
After=network.target

[Service]
WorkingDirectory=/u01/applications/gatewaydemo/Build_Output
ExecStart=/usr/bin/dotnet /u01/applications/gatewaydemo/Build_Output/GATEWAYDEMO.dll --urls=http://localhost:8845
Restart=always
RestartSec=10
SyslogIdentifier=gatewaydemo
User=eai

[Install]
WantedBy=multi-user.target
```



gatewaydemo.service
```bash
[Unit]
Description=gatewaydemo .NET Core Application
After=network.target

[Service]
WorkingDirectory=/u01/applications/gatewaydemo/Build_Output
ExecStart=/usr/bin/dotnet /u01/applications/gatewaydemo/Build_Output/GATEWAYDEMO.dll --urls=http://localhost:8484
Restart=always
RestartSec=10
SyslogIdentifier=gatewaydemo
User=eai

[Install]
WantedBy=multi-user.target
```





Replace /path/to/your/application with the actual path to your .NET Core application and your_username with the username that should run the service. Ensure that the ExecStart line points to the correct location of the dotnet executable and your application DLL.

Reload systemd and Start the Service:
After creating the service unit file, reload systemd to read the new configuration and start the service:
```bash
sudo systemctl daemon-reload
sudo systemctl start hello-linux
```
Enable Automatic Start on Boot:
If you want the service to start automatically when the system boots, enable it:
```bash
sudo systemctl enable hello-linux
```
Check Service Status:
You can check the status of your service to ensure it's running:
```bash
sudo systemctl status hello-linux
```

#### Set Up Reverse Proxy (Optional):
If you want to expose your application to the internet, you may need to set up a reverse proxy using a web server like Nginx or Apache. Configure the reverse proxy to forward requests to your .NET Core application running on a specific port.

#### Configure Firewall (Optional):
If you have a firewall enabled on your Linux server, ensure that it allows traffic on the port your application is listening on.
