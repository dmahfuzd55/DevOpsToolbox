#!/bin/bash

# Update the YUM repository
echo "[TASK 1] Updating YUM repository"
sudo yum update -y

# Install Ansible
echo "[TASK 2] Installing Ansible"
sudo yum install -y ansible

# Display Ansible version
echo "Ansible installed successfully!"
ansible --version