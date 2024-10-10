#!/bin/bash

## !IMPORTANT ##
#
## This script is tested only in CentOS 7. If you are using a different version of CentOS, modify the script as needed.
#

echo "[TASK 1] Disable and turn off SWAP"
sed -i '/swap/d' /etc/fstab
swapoff -a

echo "[TASK 2] Enable and Load Kernel modules"
cat <<EOF | tee /etc/modules-load.d/containerd.conf
overlay
br_netfilter
EOF
modprobe overlay
modprobe br_netfilter

echo "[TASK 3] Add Kernel settings"
cat <<EOF | tee /etc/sysctl.d/kubernetes.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF
sysctl --system

echo "[TASK 4] Install containerd runtime"
yum install -y yum-utils device-mapper-persistent-data lvm2
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum install -y containerd.io
containerd config default | tee /etc/containerd/config.toml
sed -i 's/SystemdCgroup \= false/SystemdCgroup \= true/g' /etc/containerd/config.toml
systemctl restart containerd
systemctl enable containerd

echo "[TASK 5] Add repo for Kubernetes"
cat <<EOF | tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-\$basearch
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF

echo "[TASK 6] Install Kubernetes components (kubeadm, kubelet, kubectl)"
yum install -y kubeadm kubelet kubectl

echo "[TASK 7] Update /etc/hosts file"
cat <<EOF | tee -a /etc/hosts
172.16.16.100   kmaster.eai.com   kmaster
172.16.16.101   kworker1.eai.com   kworker1
172.16.16.102   kworker2.eai.com   kworker2
EOF