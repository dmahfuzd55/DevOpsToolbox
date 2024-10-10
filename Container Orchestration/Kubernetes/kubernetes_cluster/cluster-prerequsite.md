<h2 align="center">
Cluster Prerequsite Command and Usage Documentation
</h2>





### 1. Change Docker Default Path

Remove running image
```bash
sudo docker stop $(sudo docker ps -q) && sudo docker rm $(sudo docker ps -a -q) && sudo docker rmi $(sudo docker images -q)
```

```bash
sudo systemctl stop docker
sudo systemctl stop docker.socket
sudo mkdir -p /var/lib/longhorn/docker
sudo cp -r /var/lib/docker/* /var/lib/longhorn/docker/
sudo nano /etc/docker/daemon.json

# Add or update with:
{
  "data-root": "/var/lib/longhorn/docker"
}

# If necessary, update the Docker service file:
sudo EDITOR=vim systemctl edit docker

# Add the following lines:
# [Service]
ExecStart=
ExecStart=/usr/bin/dockerd --data-root=/var/lib/longhorn/docker

sudo systemctl daemon-reload
sudo systemctl start docker
docker info | grep "Docker Root Dir"
```

---------------------------------------

Cluster Storage Information
---------------------------

Command to Check Total Storage Size of the Filesystem
```bash
df -h /var/lib/longhorn/docker
```

Check consume storage size
```bash
du -sh /var/lib/longhorn/
```

Check for Disk Usage by Containers and Images
```bash
docker system df
```

Remove dangling images and containers:

```bash
docker system prune -a
```

Clean up volumes (optional):
```bash
docker volume prune
```


Analyze overlay2 Layers
You can manually inspect the overlay2 directory to identify large subdirectories using:
```bash
sudo du -sh /var/lib/longhorn/docker/overlay2/*
```






#### 1. Change Kubelet Path

#### a. Stop Kubelet
Stop the kubelet service:

```bash
sudo systemctl stop kubelet
```
#### b. Move Kubelet Directory
Move the existing kubelet directory to the new location:

```bash
sudo mv /var/lib/kubelet /var/lib/longhorn/kubelet
```
#### c. Configure Kubelet to Use New Path
Edit the kubelet configuration file, typically /var/lib/kubelet/kubeadm-flags.env or a similar location:

```bash
sudo nano /etc/default/kubelet
```
Add or modify the configuration to include the new root directory:

```bash
KUBELET_EXTRA_ARGS="--root-dir=/var/lib/longhorn/kubelet --container-runtime=docker --container-runtime-endpoint=unix:///var/run/docker.sock"
```
#### d. Start Kubelet

Start the kubelet service:

```bash
sudo systemctl start kubelet
```
#### 3. Ensure Persistent Storage for Other Critical Paths
Ensure that any other critical paths (like etcd data, log directories, etc.) are also configured to use persistent volumes.

Example: Move Etcd Data Directory (if using self-hosted etcd)
#### a. Stop Etcd
Stop the etcd service:

```bash
sudo systemctl stop etcd
```
#### b. Move Etcd Data Directory
Move the etcd data directory to the new location:

```bash
sudo mv /var/lib/etcd /var/lib/longhorn/etcd
```
#### c. Configure Etcd to Use New Path
Edit the etcd service file to point to the new data directory:

```bash
sudo nano /etc/systemd/system/etcd.service
```
Update the --data-dir parameter:

```ini
ExecStart=/usr/local/bin/etcd --data-dir=/var/lib/longhorn/etcd
```
#### d. Start Etcd
Start the etcd service:

```bash
sudo systemctl start etcd
```
#### 4. Persistent Volume for Longhorn
Ensure Longhorn is properly set up to provide persistent volumes. Create a StorageClass and PersistentVolumeClaim to be used by Docker, kubelet, and other services.

Example StorageClass for Longhorn
```yaml
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: longhorn
provisioner: driver.longhorn.io
parameters:
  numberOfReplicas: "3"
  staleReplicaTimeout: "30"
```
Example PersistentVolumeClaim
```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: longhorn-pvc
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 100Gi
  storageClassName: longhorn
```
#### 5. Monitor and Validate
#### a. Monitor Disk Usage
Ensure you have proper monitoring in place to track disk usage and performance, using tools like Prometheus and Grafana.

#### b. Validate Configuration
Make sure all configurations are correctly applied, and the services are running as expected without errors.

```bash
sudo systemctl status docker
sudo systemctl status kubelet
sudo systemctl status etcd
```
