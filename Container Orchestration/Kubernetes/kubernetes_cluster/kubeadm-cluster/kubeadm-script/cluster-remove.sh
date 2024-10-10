#!/bin/bash


echo "[TASK 1] Drain and Delete Nodes:"
kubectl drain <node-name> --delete-local-data --force --ignore-daemonsets
kubectl delete node <node-name>

echo "[TASK 2] Reset the Control Plane Node:"
sudo kubeadm reset -f

echo "[TASK 3] Remove Configuration and Data:"
sudo rm -rf /etc/kubernetes/

echo "[TASK 4] Remove Container Runtime Data:"
sudo rm -rf /var/lib/docker/

echo "[TASK 5] Remove CNI (Container Network Interface) Data:"
sudo rm -rf /etc/cni/ /opt/cni/ /var/lib/cni/

echo "[TASK 5] Remove kubelet and kubectl:"
sudo yum remove -y kubelet kubectl

echo "[TASK 6] Clean Up iptables Rules:"
sudo iptables -F && sudo iptables -t nat -F && sudo iptables -t mangle -F && sudo iptables -X

echo "[TASK 6] Remove Remaining Kubernetes Packages:"
sudo yum remove -y kubeadm

echo "[TASK 6] Remove kubeconfig Files:"
rm ~/.kube/config







