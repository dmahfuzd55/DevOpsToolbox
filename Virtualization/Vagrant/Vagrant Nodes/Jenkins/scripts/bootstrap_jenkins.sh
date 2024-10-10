#!/bin/bash

# Provisioning script for Jenkins server

# Install Java
echo "[TASK 1] Install Java"
apt-get update
apt-get install -y openjdk-17-jdk openjdk-17-jre

# Install Jenkins
# Download and import Jenkins repository key
echo "[TASK 2] Download and import Jenkins repository key"
curl -fsSL https://pkg.jenkins.io/debian/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null

# Add Jenkins repository to package sources
echo "[TASK 3] Add Jenkins repository to package sources"
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

# Update package lists
echo "[TASK 4] Update package lists"
sudo apt-get update

# Install Jenkins
echo "[TASK 5] Install Jenkins"
sudo apt-get install -y jenkins

# Start Jenkins service
echo "[TASK 6] Start Jenkins service"
systemctl start jenkins

# Configure Jenkins plugins and settings
# (You can add additional configuration steps here, such as installing specific plugins, setting up authentication, etc.)

# Additional configuration specific to the Jenkins server goes here