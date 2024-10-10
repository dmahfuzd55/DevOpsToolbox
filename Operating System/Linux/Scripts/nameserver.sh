#!/bin/bash

# check name server
sudo vim /etc/resolv.conf

# Set nameserver
nameserver 210.4.77.180

# Update DNS System resulation

sudo systemctl restart systemd-resolved