<h2 align="center">
Kafka Cluster Setup and Usage Documentation
</h2>

Kafka Setup

Playbook for kafka

```bash
ansible-playbook playbooks/kafka/kafka_zookeeper.yaml -u eai -b --ask-become-pass
```
```bash
ansible-playbook -i /mnt/d/DevOps/Ansible/Inventory/inventory.yaml -l kubernetesnodes -u eai -b --ask-become-pass /mnt/d/DevOps/Ansible/Playbook/Kubernetes/bootstrap.yaml

ansible-playbook -i /mnt/d/DevOps/GitHub/DevOps/Infrastructure_as_code/Ansible/Testing/Local/Inventory/inventory.yaml /mnt/d/DevOps/GitHub/DevOps/Infrastructure_as_code/Ansible/Testing/Local/Playbook/Kubernetes/bootstrap.yaml -u eai
```
Kubernetes Playbook for kubernetesmaster
```bash
ansible-playbook -i /mnt/d/DevOps/Ansible/Inventory/inventory.yaml -l kubernetesmaster -u eai -b --ask-become-pass /mnt/d/DevOps/Ansible/Playbook/Kubernetes/bootstrap_kmaster.yaml
```
Kubernetes Playbook for kubernetesworker
```bash
ansible-playbook -i /mnt/d/DevOps/Ansible/Inventory/inventory.yaml -l kubernetesworker -u eai -b --ask-become-pass /mnt/d/DevOps/Ansible/Playbook/Kubernetes/bootstrap_kworker.yaml
```