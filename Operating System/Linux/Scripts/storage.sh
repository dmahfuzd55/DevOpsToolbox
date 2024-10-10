#!/bin/bash

# View the top 10 largest directories in the root filesystem
sudo du -sh /* | sort -rh | head -n 10

# View the top 10 largest directories under /var/lib/kubelet
sudo du -sh /var/lib/kubelet/* | sort -rh | head -n 10

# Check for large log files
sudo du -sh /var/log/* | sort -rh | head -n 10

# Find large files across the system
sudo find / -type f -size +100M -exec ls -lh {} \; | sort -rh -k 5 | head -n 10

# Find directory file size
sudo du -ahx / | sort -rh | head -20