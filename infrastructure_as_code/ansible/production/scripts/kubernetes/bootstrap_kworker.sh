#!/bin/bash

echo "[TASK 1] Install sshpass"
yum -y install sshpass

echo "[TASK 2] Transfer join script from master node"
sshpass -p "Jbl@4567" scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no eai@kmaster.eai.com:/joincluster.sh /joincluster.sh

echo "[TASK 3] Execute the join script to join the node to the Kubernetes cluster"
bash /joincluster.sh