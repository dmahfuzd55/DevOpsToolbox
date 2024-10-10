#!/bin/bash

## !IMPORTANT ##
#
## This script is tested only in the generic/ubuntu2204 Vagrant box
## If you use a different version of Ubuntu or a different Ubuntu Vagrant box test this again
#

echo "[TASK 1] Enable ssh password authentication"
sed -i 's/^PasswordAuthentication .*/PasswordAuthentication yes/' /etc/ssh/sshd_config
echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config
systemctl reload sshd

echo "[TASK 2] Set root password"
echo -e "kubeadmin\nkubeadmin" | passwd root >/dev/null 2>&1
echo "export TERM=xterm" >> /etc/bash.bashrc

echo "[TASK 3] Add a new user 'eai'"
useradd -m -s /bin/bash eai
echo -e "Dd912770\nDd912770" | passwd eai

echo "[TASK 4] Configure sudo for 'eai' user"
echo 'eai ALL=(ALL:ALL) ALL' >> /etc/sudoers
echo 'eai ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

echo "[TASK 5] Update /etc/hosts file"
cat <<EOF | tee -a /etc/hosts
172.16.16.111   kafkanode1.eai.com   kafkanode1
172.16.16.112   kafkanode2.eai.com   kafkanode2
172.16.16.113   kafkanode3.eai.com   kafkanode3
EOF

# Run visudo to check and update the sudoers file
# visudo

# You can also reload the sudo configuration if needed
# This depends on your system configuration, so it may not be necessary in all cases
# For example, on some systems, you can use 'sudo -k' to clear cached credentials
# systemctl reload sudo