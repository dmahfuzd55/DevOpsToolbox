#!/bin/bash

## !IMPORTANT ##
#
## This script is tested only in the generic/ubuntu2204 Vagrant box
## If you use a different version of Ubuntu or a different Ubuntu Vagrant box test this again
#

echo "[TASK 1] Reset cluster"
sudo kubeadm reset
rm -rf .kube/
sudo rm -rf /etc/kubernetes/
sudo rm -rf /var/lib/kubelet/
sudo rm -rf /var/lib/etcd

echo "[TASK 2] put SELinux to permissive mode"
setenforce 0 

echo "[TASK 3] enable net.bridge.bridge-nf-call-ip6tables and net.bridge.bridge-nf-call-iptables"
sudo sed -i --follow-symlinks 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/sysconfig/selinux
modprobe br_netfilter 

sudo cat <<EOF | sudo tee /etc/sysctl.d/kube.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sudo sysctl --system

echo "[TASK 4] Add Kube repo fo kubeadm, kubelet, kubectl components"
cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
exclude=kube*
EOF


echo "[TASK 5] Install ans start Kube components ans services:"
sudo yum update
sudo yum upgrade
sudo yum install -y kubelet kubeadm kubectl --disableexcludes=kubernetes

