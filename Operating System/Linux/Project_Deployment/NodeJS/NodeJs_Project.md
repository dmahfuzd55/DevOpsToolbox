<h2 align="center">
NodeJs Project Command and Usage Documentation
</h2>


### Install nodejs Centos

### Install default version

# Update package lists
```bash
sudo dnf update -y
```

# Install Node.js and npm
```bash
sudo dnf install -y nodejs npm
```

# Install React dependencies
```bash
npm install react react-dom
```

# Install PM2 globally
```bash
sudo npm install -g pm2
```

### Install specific version

To install a specific version of Node.js and npm, you can use a version manager like NVM (Node Version Manager). Here's how you can install Node.js version v16.20.2 and npm version 8.19.4 using NVM:

Install NVM:
If you haven't already installed NVM, you can do so by running the installation script provided on the NVM GitHub repository:

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
```
This command will download and run the NVM installation script, which will install NVM on your system.

Install Node.js version v16.20.2:
Once NVM is installed, you can use it to install Node.js version v16.20.2:
```bash
nvm install v16.20.2
```
This command will download and install Node.js version v16.20.2 using NVM.

Set Node.js version v16.20.2 as the default (optional):
If you want to make Node.js version v16.20.2 the default version on your system, you can use the following command:
```bash
nvm alias default v16.20.2
```
This command will set Node.js version v16.20.2 as the default version that NVM will use.

Install npm version 8.19.4:
NPM (Node Package Manager) is typically installed automatically alongside Node.js. However, you can check the installed version using the following command:
```bash
npm --version
```

### NodeJs project run
```bash
pm2 start index.js --name project_name
```

### React build file run
```bash
pm2 serve build 8080 --spa --name "frontend-customer-amend"
```


### Nodejs install Ubuntu
