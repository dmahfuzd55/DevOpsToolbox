# Filebeat Command and Usage Documentation

## Table of Contents
- [Filebeat Command and Usage Documentation](#filebeat-command-and-usage-documentation)
  - [Table of Contents](#table-of-contents)
  - [Introduction](#introduction)
  - [Installation](#installation)
    - [Step 1: Install Filebeat](#step-1-install-filebeat)
  - [Configuration](#configuration)
    - [Step 2: Configure Filebeat](#step-2-configure-filebeat)
  - [Starting Filebeat](#starting-filebeat)
    - [Step 3: Enable and Start Filebeat](#step-3-enable-and-start-filebeat)
  - [Configuration Check](#configuration-check)
  - [Uninstallation](#uninstallation)

## Introduction

Filebeat is a lightweight log shipper designed to forward and centralize logs. It can be used to collect logs like syslog, auth.log, or any other log files on the system.

> 📌 **Note:** For official installation instructions, visit the [Filebeat Installation and Configuration Guide](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-installation-configuration.html).

## Installation

### Step 1: Install Filebeat

```bash
# Download Filebeat
curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-8.15.0-amd64.deb

# Install the downloaded package
sudo dpkg -i filebeat-8.15.0-amd64.deb

# List available Filebeat modules
filebeat modules list

# Enable the system module
filebeat modules enable system
```

## Configuration

### Step 2: Configure Filebeat

```bash
# Navigate to the Filebeat configuration directory
cd /etc/filebeat

# Edit the configuration file
sudo vim filebeat.yml

# Set up Filebeat
filebeat setup -e
```

## Starting Filebeat

### Step 3: Enable and Start Filebeat

```bash
# Enable Filebeat to start on boot
sudo systemctl enable filebeat

# Start Filebeat service
sudo systemctl start filebeat
```

## Configuration Check

Verify your Filebeat configuration:

```bash
# Test the configuration
sudo filebeat test config

# Test the output
sudo filebeat test output

# Check Elasticsearch indices (replace with your Elasticsearch URL)
curl -X GET "http://172.8.9.52:9200/_cat/indices?v"
```

## Uninstallation

If you need to remove Filebeat, follow these steps:

```bash
# Remove Filebeat package
sudo apt-get purge filebeat

# Alternative removal command
sudo apt-get remove filebeat

# Remove unnecessary dependencies
sudo apt-get autoremove

# Remove Filebeat configuration directory
sudo rm -rf /etc/filebeat

# Remove Filebeat data directory
sudo rm -rf /var/lib/filebeat

# Remove Filebeat log directory
sudo rm -rf /var/log/filebeat
```

---

**Pro Tip:** Always backup your configuration before making changes or uninstalling.

