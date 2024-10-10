#!/bin/bash

echo "[TASK 1] Rancher installation"
sudo docker run --privileged -d --restart=unless-stopped -p 8844:80 -p 8855:443 -v /opt/rancher:/var/lib/rancher rancher/rancher

curl --insecure -sfL https://172.8.9.41:8855/v3/import/jtb97w2wqxtnbst48pt78bxtl4gfwpzhrbtjzqdjtfv7j6b8286t8d.yaml -0 /u01/dev
ops/kubernetes/rancher-node.yaml



