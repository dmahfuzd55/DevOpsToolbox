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

# Add 'eai' to sudoers
echo 'eai ALL=(ALL:ALL) ALL' | tee -a /etc/sudoers

echo "[TASK 4] Generate and copy SSH keys for Ansible"
su - eai -c 'ssh-keygen -t ed25519 -C "ansible" -N ""'
su - eai -c 'ssh-copy-id -i $HOME/.ssh/id_ed25519.pub eai@172.16.16.100'
su - eai -c 'ssh-copy-id -i $HOME/.ssh/id_ed25519.pub eai@172.16.16.101'
su - eai -c 'ssh-copy-id -i $HOME/.ssh/id_ed25519.pub eai@172.16.16.102'

echo "[TASK 5] Create and mount shared folder"
sudo mkdir /home/eai/shared
sudo mount -t vboxsf DevOps /home/eai/shared

echo "[TASK 6] Add entry to /etc/fstab"
echo 'D_drive  /home/eai/shared  vboxsf  defaults  0  0' | sudo tee -a /etc/fstab

echo "SSH key generation, copying, shared folder creation, mounting, and adding 'eai' to sudoers completed."