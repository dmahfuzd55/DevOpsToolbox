#!/bin/bash

# Specify a directory where the user has write permissions
LOG_DIR="/tmp"

echo "[TASK 1] Pull required containers"
kubeadm config images pull >/dev/null 2>&1

echo "[TASK 2] Initialize Kubernetes Cluster"
kubeadm init --apiserver-advertise-address=172.16.16.100 --pod-network-cidr=192.168.0.0/16 >> "$LOG_DIR/kubeinit.log" 2>/dev/null

echo "[TASK 3] Deploy Calico network"
kubectl --kubeconfig=/etc/kubernetes/admin.conf create -f https://docs.projectcalico.org/v3.18/manifests/calico.yaml >/dev/null 2>&1

echo "[TASK 4] Generate and save cluster join command to $LOG_DIR/joincluster.sh"
kubeadm token create --print-join-command > "$LOG_DIR/joincluster.sh" 2>/dev/null

# Set execute permissions for joincluster.sh
chmod +x "$LOG_DIR/joincluster.sh"