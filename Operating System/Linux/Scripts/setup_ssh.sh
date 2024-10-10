#!/bin/bash

# Set the username and target hosts
echo "[TASK 1] Set the username and target hosts"
USERNAME="eai"
HOSTS=("172.16.16.100" "172.16.16.101" "172.16.16.102")

# Generate the SSH key
echo "[TASK 2] Generate the SSH key"
ssh-keygen -t ed25519 -C "ansible" -f ~/.ssh/id_ed25519 -N ""

# Copy the SSH key to each host
echo "[TASK 3] Copy the SSH key to each host"
for HOST in "${HOSTS[@]}"
do
  ssh-copy-id -i ~/.ssh/id_ed25519.pub "$USERNAME@$HOST"
done

echo "SSH key copied to all hosts successfully!"