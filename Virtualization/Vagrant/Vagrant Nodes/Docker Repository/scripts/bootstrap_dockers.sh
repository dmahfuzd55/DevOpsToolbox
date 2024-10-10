#!/bin/bash

# Provisioning script for Jenkins server

# Update the system
sudo apt-get update
sudo apt-get upgrade -y

# Install Docker dependencies
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common

# Add Docker's official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Add Docker repository
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu focal stable" | sudo tee /etc/apt/sources.list.d/docker.list >/dev/null

# Update the system again to include Docker repository
sudo apt-get update

# Install Docker engine
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# Add the current user to the docker group
sudo usermod -aG docker $USER

# Start Docker on boot
sudo systemctl enable docker.service
sudo systemctl enable containerd.service
