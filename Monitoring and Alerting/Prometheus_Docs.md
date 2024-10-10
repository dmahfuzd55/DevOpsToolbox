
<h2 align="center">
Prometheus Setup and Usage Documentation
</h2>


### Prometheus Installation:

Download Prometheus:
Visit the Prometheus download page (https://prometheus.io/download/) and grab the latest version of Prometheus for your operating system.

Extract the Archive:

```bash
tar -xvf prometheus-*.tar.gz
cd prometheus-*
```

Create a Configuration File:
Create a prometheus.yml configuration file. You can use the provided example configurations or create your own. Here's a simple example:

```yml
global:
  scrape_interval: 15s

scrape_configs:
  - job_name: 'prometheus'
    static_configs:
      - targets: ['localhost:9090']
```


Start Prometheus:
Run Prometheus using the following command:

```bash
./prometheus --config.file=prometheus.yml
```

Prometheus will now be running, and you can access its web UI at http://localhost:9090.



### Prometheus Installation - Docker

First check docker and docker compose install or not

```bash
docker --version

docker-compose --version
```

Create following file in desire directory

docker-compose.yaml  Dockerfile  Volumes

docker-compose.yaml

```yml
version: '3'
services:
  prometheus:
    image: prom/prometheus
    container_name: prometheus
    volumes:
      - /mnt/d/DevOps/Prometheus/Volumes/prometheus.yml:/etc/prometheus/prometheus.yml
    command:
      - '--config.file=/etc/prometheus/prometheus.yml'
    ports:
      - '9090:9090'

  grafana:
    image: grafana/grafana
    container_name: grafana
    ports:
      - '3000:3000'
```

In volume 

prometheus.yml file
```yml
global:
  scrape_interval: 5s

scrape_configs:
  - job_name: 'nodejs'
    static_configs:
      - targets: ['172.30.6.77:8844']
  - job_name: 'dotnetcore'
    static_configs:
      - targets: ['172.30.6.77:5000']
```


# Compose file update after change any configuration

```bash
docker-compose up -d --force-recreate
```

#### Installing Prometheus and Grafana kubernetes

Go to the following repo, https://artifacthub.io/

Look for official charts for Prometheus and Grafana and the repositories into the helm repo using the following commands:

```bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts

helm search repo prometheus-community

helm repo add grafana https://grafana.github.io/helm-charts

helm repo update

kubectl create ns monitoring-alerting

helm install prometheus prometheus-community/prometheus -n monitoring-alerting

kubectl expose service prometheus-server --type=NodePort --target-port=9090 --name=prometheus-server-ext -n monitoring-alerting

helm install grafana grafana/grafana -n monitoring-alerting

kubectl expose service prometheus-operator-grafana --type=NodePort --target-port=80 --name=grafana-ext -n monitoring

kubectl get secret --namespace monitoring-alerting grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo
```



Step 1: Install Prometheus and Grafana Using Helm
Prometheus and Grafana can be installed using the kube-prometheus-stack Helm chart, which includes both Prometheus and Grafana along with other monitoring components.

Add the Prometheus Helm Repository
```bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
```


Install the kube-prometheus-stack Helm Chart
```bash
helm install prometheus-stack prometheus-community/kube-prometheus-stack \
  --namespace monitoring \
  --create-namespace
```

This command installs Prometheus, Grafana, and other monitoring components in the monitoring namespace.

To access prometheus
```bash
kubectl port-forward -n monitoring service/prometheus-operator-kube-p-prometheus 9090:9090

http://localhost:9090
```

Access Grafana Dashboard To access the Grafana dashboard:
```bash
kubectl get svc prometheus-operator-grafana -n monitoring
```
Note the EXTERNAL-IP and use it to access Grafana. The default username is admin, and the password can be retrieved using:
```bash
kubectl get secret -n monitoring prometheus-stack-grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo
```

To get access grafana with nodeport
```bash
kubectl patch service prometheus-operator-grafana -n monitoring -p '{"spec":{"type":"NodePort"}}'
```





### Prometheus install with package

To install Prometheus as a package (not using Docker) on an Ubuntu system, follow these steps:

Step-1. Update Your System
Before installing Prometheus, make sure your system is up to date:
```bash
sudo apt-get update
sudo apt-get upgrade
```

Step-2. Download Prometheus
Prometheus is distributed as a standalone binary. Download the latest stable release from the official Prometheus GitHub repository:

Visit the Prometheus releases page to find the latest version.
Download the tarball for Linux. For example:
```bash
wget https://github.com/prometheus/prometheus/releases/download/v2.54.1/prometheus-2.54.1.linux-amd64.tar.gz
```

Step-3: Extract the Tarball
After downloading, extract the tarball:
```bash
tar xvfz prometheus-*.tar.gz
```
This will create a directory with the Prometheus binaries.

Step-4. Move Binaries to a System Path
To make Prometheus available globally on your system, move the binaries to /usr/local/bin:
```bash
cd prometheus-2.54.1.linux-amd64
sudo mv prometheus /usr/local/bin/
sudo mv promtool /usr/local/bin/
```
Step-5. Create Configuration and Data Directories
Create directories for Prometheus configuration files and data storage:
```bash
sudo mkdir /etc/prometheus
sudo mkdir /var/lib/prometheus
```

Step-6. Move the default configuration file to /etc/prometheus:
```bash
sudo mv prometheus.yml /etc/prometheus/
```

Step-7. Create a Prometheus Service File
To manage Prometheus with systemd, create a service file:
```bash
sudo vim /etc/systemd/system/prometheus.service
```
Add the following content to the file:

```ini
[Unit]
Description=Prometheus
Wants=network-online.target
After=network-online.target

[Service]
User=prometheus
Group=prometheus
Type=simple
ExecStart=/usr/local/bin/prometheus \
  --config.file=/etc/prometheus/prometheus.yml \
  --storage.tsdb.path=/var/lib/prometheus/ \
  --web.console.templates=/usr/local/bin/consoles \
  --web.console.libraries=/usr/local/bin/console_libraries

[Install]
WantedBy=multi-user.target
```

Step-8. Create Prometheus User and Set Permissions
Create a dedicated user for running Prometheus and set the necessary permissions:
```bash
sudo useradd --no-create-home --shell /bin/false prometheus
sudo chown -R prometheus:prometheus /etc/prometheus /var/lib/prometheus
sudo chown prometheus:prometheus /usr/local/bin/prometheus /usr/local/bin/promtool
```

Step-9. Edit prometheus.yml file to scrap
```bash
cd /etc/prometheus

sudo vim prometheus.yml
```

Add following value
```bash
global:
  scrape_interval: 5s

scrape_configs:
  - job_name: "prometheus"

    static_configs:
      - targets: ["localhost:9090"]

  - job_name: 'node-exporter'
    static_configs:
      - targets: ['172.23.211.31:9100']
```




10. Start and Enable Prometheus
Enable and start the Prometheus service:
```bash
sudo systemctl daemon-reload
sudo systemctl start prometheus
sudo systemctl enable prometheus
```

11. Verify Prometheus Installation
Check the status of Prometheus to ensure it’s running:
```bash
sudo systemctl status prometheus
```

Query
-----


Total requests

->http_requests_total


Total requests in a period of time

->round(increase(http_requests_total[1m]))

