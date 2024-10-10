<h2 align="center">
Harbor Command and Usage Documentation
</h2>


### Harbor Installation

#### Online installer: 
The online installer downloads the Harbor images from Docker hub. For this reason, the installer is very small in size.

#### Offline installer: 

Use the offline installer if the host to which are deploying Harbor does not have a connection to the Internet. The offline installer contains pre-built images, so it is larger than the online installer.

Prerequisites:

A Linux server (physical or virtual) with Docker and Docker Compose installed. You can use CentOS, Ubuntu, or another supported distribution.
Docker version 17.06.0 or later.
Docker Compose version 1.18.0 or later.
Sufficient resources (CPU, memory, disk space) for Harbor to run smoothly.
Internet connectivity for downloading Harbor images and dependencies.
Download Harbor:
You can download the Harbor release package from the Harbor GitHub repository. Choose the version you want to install. For example, to download version v2.10.1:

```bash
wget https://github.com/goharbor/harbor/releases/download/v2.10.1/harbor-offline-installer-v2.10.1.tgz
```

Extract the Package:
Extract the downloaded package:
```bash
tar xvf harbor-offline-installer-v2.10.1.tgz
```
Configure Harbor:
Navigate to the extracted directory and edit the harbor.yml configuration file to customize Harbor settings such as hostname, port, certificates, authentication, storage, etc.:
```bash
cd harbor
cp harbor.yml.tmpl harbor.yml
vi harbor.yml
```
Modify the harbor.yml configuration according to your requirements.
```yaml
# Configuration file of Harbor

# The IP address or hostname to access admin UI and registry service.
# DO NOT use localhost or 127.0.0.1, because Harbor needs to be accessed by external clients.
hostname: 172.8.9.41

# http related config
http:
  # port for http, default is 80. If https enabled, this port will redirect to https port
  port: 4484

# https related config
# https:
  # https port for harbor, default is 443
  # port: 443
  # The path of cert and key files for nginx
  # certificate: /your/certificate/path
  # private_key: /your/private/key/path
  # enable strong ssl ciphers (default: false)
  # strong_ssl_ciphers: false
```

Install Harbor:
Run the Harbor installation script:
```bash
sudo ./install.sh
```
This script will set up Harbor using Docker Compose based on the configuration provided in harbor.yml.

Access Harbor:
Once the installation is complete, you can access Harbor via a web browser using the hostname or IP address of your server and the port specified in the configuration (default is 80 for HTTP and 443 for HTTPS). For example:
```bash
http://<your-harbor-hostname>/
```


--------------------------------------Harbor on Kubernetes--------------------------------------------------

## Deploy Harbor on Kubernetes

#### Create namespace
```bash
kubect create namespace harbor
```

#### Harbor repo add
```bash
helm repo add harbor https://helm.goharbor.io
```

#### Go where harbor repo extract
```bash
cd /mnt/d/DevOps/Office/DevOps/Kubernetes/Local/Project/harbor
```

#### Extract harbor repo
```bash
helm fetch harbor/harbor --untar
```

#### Extract file in harbor repo
```bash
ls

Chart.yaml  LICENSE  README.md  templates  values.yaml
```

#### Edit values.yaml
```yaml
# Service
expose:
  # Set how to expose the service. Set the type as "ingress", "clusterIP", "nodePort" or "loadBalancer"
  # and fill the information in the corresponding section
  type: loadBalancer
  tls:
    # Enable TLS or not.
    # Delete the "ssl-redirect" annotations in "expose.ingress.annotations" when TLS is disabled and "expose.type" is "ingress"
    # Note: if the "expose.type" is "ingress" and TLS is disabled,
    # the port must be included in the command when pulling/pushing images.
    # Refer to https://github.com/goharbor/harbor/issues/5291 for details.
    enabled: false

# Volumen
persistence:
  enabled: true
  # Setting it to "keep" to avoid removing PVCs during a helm delete
  # operation. Leaving it empty will delete PVCs after the chart deleted
  # (this does not apply for PVCs that are created for internal database
  # and redis components, i.e. they are never deleted automatically)
  resourcePolicy: "keep"
  persistentVolumeClaim:
    registry:
      # Use the existing PVC which must be created manually before bound,
      # and specify the "subPath" if the PVC is shared with other components
      existingClaim: ""
      # Specify the "storageClass" used to provision the volume. Or the default
      # StorageClass will be used (the default).
      # Set it to "-" to disable dynamic provisioning
      storageClass: ""
      subPath: ""
      accessMode: ReadWriteOnce
      size: 5Gi
      annotations: {}
    jobservice:
      jobLog:
        existingClaim: ""
        storageClass: ""
        subPath: ""
        accessMode: ReadWriteOnce
        size: 1Gi
        annotations: {}
    # If external database is used, the following settings for database will
    # be ignored
    database:
      existingClaim: ""
      storageClass: ""
      subPath: ""
      accessMode: ReadWriteOnce
      size: 1Gi
      annotations: {}
    # If external Redis is used, the following settings for Redis will
    # be ignored
    redis:
      existingClaim: ""
      storageClass: ""
      subPath: ""
      accessMode: ReadWriteOnce
      size: 1Gi
      annotations: {}
    trivy:
      existingClaim: ""
      storageClass: ""
      subPath: ""
      accessMode: ReadWriteOnce
      size: 5Gi
      annotations: {}
```


#### Install harbor
```bash
helm install harbor . harbor
```

#### Check harbor resource
```bash
kubectl get all -n harbor
```


#### Uninstall harbor
```bash
helm list -n harbor
```

```bash
helm uninstall harbor
```


````````````````````````````````````````Harbor Uninstall``````````````````````````````````````

To uninstall Harbor, you typically need to reverse the installation steps. Here’s a general approach for uninstalling Harbor:

Stop and Remove Harbor Containers:

First, you should stop and remove all Harbor-related containers. Use Docker commands to stop and remove these containers:
```bash
docker-compose down
```
If you used a different method for installation (like Helm or directly with Docker commands), make sure to stop and remove containers accordingly.

Remove Harbor Data Volumes:

Harbor uses Docker volumes to store data. Remove these volumes to clean up all data:

```bash
docker volume rm $(docker volume ls -q)
```
Be cautious with this command as it will delete all Docker volumes, not just those related to Harbor.

Remove Harbor Configuration and Data Directories:

Depending on your setup, Harbor may store its configuration and data in specific directories. These are usually located in the directory where you installed Harbor. For example, if you installed it in /opt/harbor, you would remove that directory:

```bash
sudo rm -rf /opt/harbor
```
Adjust the path according to where you installed Harbor.


````````````````````````````````````````Harbor Backup and Restore``````````````````````````````````````

Backup Procedure

1. Stop Harbor Services:
Before taking the backup, it’s recommended to stop Harbor to ensure data consistency.

```bash
sudo docker-compose down
```
2. Backup Harbor Data:
You need to back up the persistent data volumes where Harbor stores images, database data, and configuration.
```bash
cd /data

sudo tar -czvf harbor_data_backup.tar.gz harbor-data
```

Restore Procedure
Prepare the New Environment:
On the new environment, ensure that you have Docker, Docker Compose, and Harbor installed.

Download Harbor:
Download and extract Harbor from the official Harbor GitHub repository.
Stop Harbor Services on the New Environment:
If Harbor is already running in the new environment, stop it.

```bash
sudo docker-compose down
```

Copy the Backup to the New Environment:
Transfer the backup archive (harbor_backup.tar.gz) and the configuration backup (harbor.yml.backup) to the new environment.

Example:

```bash
scp harbor_backup.tar.gz user@new-server:/data
```
Extract the Backup:
On the new environment, extract the backup archive to restore the data.

```bash
sudo tar -xzvf harbor_data_backup.tar.gz
```

Now run the docker-compose.yml file

```bash
sudo docker-compose up -d
```

### Image build and push to harbour

#### Configure Docker to Use HTTP for the Registry

Step-1 Edit docker daemon.json file
```bash
sudo vim /etc/docker/daemon.json
```

Step-2 Add the following configuration, replacing 172.23.211.28:4484 with your registry's address:
```json
{
  "insecure-registries" : ["172.23.211.28:4484"]
}
```

Restart the Docker Daemon:
After modifying the configuration, you need to restart the Docker daemon for the changes to take effect:
```bash
sudo systemctl restart docker
```

Authenticate with the Docker Registry:
```bash
docker login 172.23.211.28:4484
```

Tag an image for this project:
```bash
docker tag amlscreening-producer:01-09-24 172.23.211.28:4484/amlscreening/amlscreening-producer:01-09-24
```

Push an image to this project:
```bash
docker push 172.23.211.28:4484/amlscreening/amlscreening-producer:01-09-24
```








