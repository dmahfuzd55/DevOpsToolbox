#!/bin/bash

echo "[TASK 1] Initialize kubernetes cluster with calico network"
sudo kubeadm init --apiserver-advertise-address=172.8.9.41 --pod-network-cidr=192.168.0.0/16 >> /root/kubeinit.log 2>/dev/null

echo "[TASK 1] Initialize kubernetes cluster with flannel network"
sudo kubeadm init --apiserver-advertise-address=172.8.9.41 --pod-network-cidr=10.244.0.0/16 >> /root/kubeinit.log 2>/dev/null
sudo kubeadm init --apiserver-advertise-address=172.8.9.41 --pod-network-cidr=10.244.0.0/16

echo "[TASK 2] Add config file to home"
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

echo "[TASK 3] Deploy Calico network"
sudo kubectl --kubeconfig=/etc/kubernetes/admin.conf create -f https://docs.projectcalico.org/v3.18/manifests/calico.yaml >/dev/null 2>&1
kubectl apply -f https://docs.projectcalico.org/v3.18/manifests/calico.yaml

echo "[TASK 3] Deploy flannel network"
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

echo "[TASK 4] Generate and save cluster join command to /joincluster.sh"
kubeadm token create --print-join-command > /joincluster.sh 2>/dev/null
