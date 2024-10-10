#!/bin/bash

# Check if an SSH key pair already exists
if [ ! -f ~/.ssh/id_rsa ]; then
    echo "Generating SSH key pair..."
    ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa
fi

# Start the ssh-agent and add your SSH key
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa

# Copy the public key to the remote server
echo "Copying the public key to the remote server..."
ssh-copy-id -i ~/.ssh/id_rsa.pub eai@172.16.16.100

# Test the passwordless authentication
echo "Testing passwordless authentication..."
ssh eai@172.16.16.100 "echo Passwordless authentication is working."

# Copy the script to the remote server
echo "Copying the joincluster script to the remote server..."
scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no kmaster.eai.com:/joincluster.sh /joincluster.sh

# Run the remote script
echo "Running the remote script..."
/bin/bash /joincluster.sh" >/dev/null 2>&1

echo "Passwordless authentication and script execution completed."