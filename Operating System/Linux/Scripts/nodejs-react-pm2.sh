#!/bin/bash

# Update package lists
sudo dnf update -y

# Install Node.js and npm
sudo dnf install -y nodejs npm

# Install React dependencies
npm install react react-dom

# Install PM2 globally
sudo npm install -g pm2

# Install express-generator globally to scaffolding Express.js application
sudo npm install -g express-generator

echo "NodeJS environment setup complete."
