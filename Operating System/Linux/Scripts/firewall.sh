#!/bin/bash

# Enable the firewall
systemctl start firewalld
systemctl enable firewalld

# Set default zone to public
firewall-cmd --set-default-zone=public

# Allow SSH (port 22) traffic
firewall-cmd --zone=public --add-service=ssh --permanent

# Allow HTTP (port 80) traffic
firewall-cmd --zone=public --add-service=http --permanent

# Allow HTTPS (port 443) traffic
firewall-cmd --zone=public --add-service=https --permanent

# Add multiple custom ports
firewall-cmd --zone=public --add-port=12345/tcp --permanent
firewall-cmd --zone=public --add-port=23456/tcp --permanent
firewall-cmd --zone=public --add-port=34567/tcp --permanent

# Add Multiple custom ports
sudo firewall-cmd --zone=public --add-port=3001/tcp,3005/tcp,3002/tcp --permanent,3004/tcp --permanent,3006/tcp --permanent,

# Reload firewall rules to apply changes
firewall-cmd --reload

# To see all open ports:
```bash
firewall-cmd --list-ports
```

# Display current firewall rules
firewall-cmd --list-all

# Print a message indicating the script has finished
echo "Firewall configuration complete."