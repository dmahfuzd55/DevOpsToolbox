<h2 align="center">
Kubernetes Command and Usage Documentation
</h2>

Kubernetes Components (kubeadm, kubelet, kubectl):
```bash
kubeadm version
kubelet --version
kubectl version --short
```

Container Runtime (containerd):
```bash
containerd --version
```

Check service status
```bash
systemctl status kubelet
```

Kubernetes
----------
Set to access kubectl command
```bash
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```

Token generate master node
```bash
kubeadm token create --print-join-command

kubeadm join 172.16.16.100:6443 --token zzg30v.fptzfeefzwa1eh50 --discovery-token-ca-cert-hash sha256:3220901adac40913f8b24a8c9adc2bda7064700d0cbd1d19fdc66b15df702b9e
```


Your Kubernetes control-plane has initialized successfully!

To start using your cluster, you need to run the following as a regular user:

  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

Alternatively, if you are the root user, you can run:

  export KUBECONFIG=/etc/kubernetes/admin.conf

You should now deploy a pod network to the cluster.
Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
  https://kubernetes.io/docs/concepts/cluster-administration/addons/

Then you can join any number of worker nodes by running the following on each as root:

kubeadm join 172.8.9.41:6443 --token c5v2mo.nj7e3aus5kvwk4xh \
        --discovery-token-ca-cert-hash sha256:274bae74c713b67f5c42c522ea5d5f7401c6e158536efb827a8cbf548b7dcdec


## Kubernetes cluster configuration file copy to WSL
```bash
mkdir -p $HOME/.kube
sudo cp -i /mnt/d/DevOps/Office/DevOps/Kubernetes/Local/config/rancher-cluster $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```

## Kubernetes cluster configuration file copy windows to linux
```bash
ssh eai@172.30.38.21
mkdir -p $HOME/.kube

scp /d/DevOps/Office/DevOps/Kubernetes/Local/config/rancher-cluster/jblcls-dev.yaml eai@172.30.38.21:/home/eai/

ssh eai@172.30.38.21
sudo mv /home/eai/jblcls-dev.yaml /home/eai/.kube/
sudo mv jblcls-dev.yaml config

sudo chown $(id -u):$(id -g) $HOME/.kube/config
```



## Kubernetes cluster deploments

Create the deployment directly using kubectl:
```bash
kubectl create deployment nginx-deployment --image=nginx:latest --replicas=3
```
Expose the deployment to create a service that allows external access to the NGINX pods. You can expose it as a NodePort or LoadBalancer service:

```bash
kubectl expose deployment amlscreening-raw-playground --port=8080 --target-port=8080 --type=NodePort -n screening-playground --name=amlscreening-raw-playground-nodeport
```
Alternatively, if you want to use a LoadBalancer (assuming your cluster supports it):

```bash
kubectl expose deployment amlscreening-raw-playground --port=8080 --target-port=8080 --type=LoadBalancer -n screening-playground --name=amlscreening-raw-playground-loadbalancer
```

```bash
kubectl expose deployment nginx --port=80 --target-port=80 --type=NodePort --name=nginx-nodeport-service
```

```bash
kubectl patch service nginx-service -p '{"spec":{"type":"NodePort"}}'
```


## Kubernetes Cluster Information

Maximum pods per node
```bash
kubectl get nodes -o jsonpath='{range .items[*]}{.metadata.name} {.status.capacity.pods}{"\n"}{end}'
```