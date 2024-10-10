#!/bin/bash

echo "Troublshooting"

sudo rm /etc/kuberneteskubelet.conf

sudo rm /etc/kubernetes/pki/ca.crt

sudo netstat -tulpn | grep 10250

sudo netstat -tulpn | grep 6443

sudo kill -9 2910850

sudo kubeadm reset


echo "[TASK 1] Join node to Kubernetes Cluster"
udo kubeadm join 172.8.9.41:6443 --token 3yo6pf.cvmeukqsek0cvmmo --discovery-token-ca-cert-hash sha256:2c09c0fd1f55b1245da537ffb18221fe2a4fa56a85afe6b66905eb4c302e72b7
