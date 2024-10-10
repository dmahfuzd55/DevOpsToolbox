#!/bin/bash

## !IMPORTANT ##
#
## This script is tested only in the generic/centos8 Vagrant box
## If you use a different version of CentOS or a different CentOS Vagrant box, test this again

echo "[TASK 1] Enable ssh password authentication"
sed -i 's/^PasswordAuthentication .*/PasswordAuthentication yes/' /etc/ssh/sshd_config
echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config
systemctl reload sshd

echo "[TASK 2] Set root password"
echo -e "kubeadmin\nkubeadmin" | passwd root >/dev/null 2>&1
echo "export TERM=xterm" >> /etc/bashrc

echo "[TASK 3] Add a new user 'eai'"
useradd -m -s /bin/bash eai
echo -e "Dd912770\nDd912770" | passwd eai

# Add 'eai' to sudoers
echo "[TASK 4] Add 'eai' to sudoers"
echo 'eai ALL=(ALL:ALL) ALL' | tee -a /etc/sudoers

echo "[TASK 5] Create and mount shared folder"
sudo mkdir /home/eai/shared
sudo mount -t vboxsf DevOps /home/eai/shared

echo "[TASK 6] Add entry to /etc/fstab"
echo 'D_drive  /home/eai/shared  vboxsf  defaults  0  0' | sudo tee -a /etc/fstab

echo "[TASK 7] Add Docker repository for CentOS 8"
sudo dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo

echo "[TASK 8] Install Docker"
sudo dnf install -y docker-ce
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker eai

echo "[TASK 9] Install Git"
sudo dnf install -y git

echo "[TASK 10] Install Terraform"
sudo yum install -y yum-utils

echo "[TASK 11] Use yum-config-manager to add the official HashiCorp Linux repository"
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo

echo "[TASK 12] Install Terraform from the new repository."
sudo yum -y install terraform

echo "SSH key generation, copying, shared folder creation, mounting, adding 'eai' to sudoers, Docker repository addition, Docker, Git and Terraform installations completed."