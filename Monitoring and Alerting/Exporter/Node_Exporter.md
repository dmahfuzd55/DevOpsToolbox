<h2 align="center">
Node Exporter Command and Usage Documentation
</h2>

### Node Exporter Installation:

1. Download Prometheus:
Visit the Prometheus download page (https://prometheus.io/download/#node_exporter) and grab the latest version of Prometheus for your operating system.

```bash
wget https://github.com/prometheus/node_exporter/releases/download/v1.8.2/node_exporter-1.8.2.linux-amd64.tar.gz
```

2. Extract the Archive:

```bash
tar xvfz node_exporter-*.*-amd64.tar.gz
cd node_exporter-*.*-amd64
sudo mv node_exporter /usr/local/bin/
```

3. Create a Node Exporter User
Create a dedicated user for Node Exporter for security reasons:

```bash
sudo useradd --no-create-home --shell /bin/false node_exporter
```

4. Create a Systemd Service File
Create a systemd service file to manage Node Exporter as a service:

```bash
sudo nano /etc/systemd/system/node_exporter.service
```

Add the following content to the file:

```bash
[Unit]
Description=Node Exporter
Wants=network-online.target
After=network-online.target

[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=/usr/local/bin/node_exporter

[Install]
WantedBy=multi-user.target
```


5. Reload Systemd and Start Node Exporter
Reload systemd to recognize the new Node Exporter service, then start and enable it to run on boot:

```bash
sudo systemctl daemon-reload
sudo systemctl start node_exporter
sudo systemctl enable node_exporter
```
6. Verify Node Exporter Installation
```bash
sudo systemctl status node_exporter
```
You should see output indicating that Node Exporter is active and running. By default, Node Exporter runs on port 9100.


6. Configure Firewall (Optional)
If you have a firewall enabled, allow traffic on port 9100:

```bash
sudo ufw allow 9100/tcp
sudo ufw reload
```

7. Node Exporter running port
```bash
# running port 
sudo lsof -iTCP -sTCP:LISTEN | grep node_exporter

# metrics
curl http://172.23.211.31:9100/metrics
```


8. Configuring your Prometheus instances


```bash
global:
  scrape_interval: 15s

scrape_configs:
- job_name: node
  static_configs:
  - targets: ['localhost:9100']
```