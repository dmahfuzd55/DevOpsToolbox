<h2 align="center">
Ansible Setup and Usage Documentation
</h2>

Local PC Environment Setup

Basic Configuration
-------------------
1. Update Package Lists

```bash
sudo apt update
```

2. Install Ansible
```bash
sudo apt install ansible
```

3. Check the Ansible Version
```bash
ansible --version
```

4. Set up SSH connections so Ansible can connect to the managed nodes.

- Add your public SSH key to the authorized_keys file on each remote system.
    
- Creating the key pair
```bash
cd ~/.ssh
```
```bash
ls
```

```bash
ssh-keygen
   

Generating public/private rsa key pair.
Enter file in which to save the key (/home/dmahfuzd/.ssh/id_rsa):
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in /home/dmahfuzd/.ssh/id_rsa
Your public key has been saved in /home/dmahfuzd/.ssh/id_rsa.pub
The key fingerprint is:
SHA256:2qYRvvzGtsBDb2b/ohSZrjrU3ZJc2+4ON0MV798046c dmahfuzd@EAI-MAHFUZ
The key's randomart image is:
+---[RSA 3072]----+
|              .  |
|               o |
|              . .|
|         o.  . . |
|     .ooS+ o.  oo|
|    .+.*=.o.. ..=|
|   .  B.X...+  .+|
|    .. &+..o.o ..|
|    .o=++o.=+ E  |
+----[SHA256]-----+
```

```bash
ssh-copy-id -i /home/dmahfuzd/.ssh/id_rsa.pub eai@172.16.16.111
   
   
/usr/bin/ssh-copy-id: INFO: Source of key(s) to be installed: "/home/dmahfuzd/.ssh/id_rsa.pub"
The authenticity of host '172.16.16.111 (172.16.16.111)' can't be established.
RSA key fingerprint is SHA256:z4kR2WggwYEA8863PzckhaEI31nPHpSkKDfFU1CDuOE.
This key is not known by any other names
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
/usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
/usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys
eai@172.16.16.111's password:
Number of key(s) added: 1
Now try logging into the machine, with:   "ssh 'eai@172.16.16.111'"
and check to make sure that only the key(s) you wanted were added.
```

```bash
ssh eai@172.16.16.111

Last login: Wed Nov  8 07:00:34 2023 from 172.16.16.1

[eai@kafkanode1 ~]$
```

5. Configure sudo Without Password Prompt on the Ansible Agent Node
Edit the sudoers file:
```bash
sudo visudo
```
Add the following lines to allow passwordless sudo for a user (replace eai with your username):
```bash
username ALL=(ALL) NOPASSWD: ALL
eai ALL=(ALL) NOPASSWD: ALL
```

SSH key without password
```bash
ssh-keygen -t ed25519 -C "ansible"

Generating public/private ed25519 key pair.
Enter file in which to save the key (/home/dmahfuzd/.ssh/id_ed25519): /home/dmahfuzd/.ssh/ansible
Enter passphrase (empty for no passphrase): 
Enter same passphrase again: 
Your identification has been saved in /home/dmahfuzd/.ssh/ansible
Your public key has been saved in /home/dmahfuzd/.ssh/ansible.pub
The key fingerprint is:
SHA256:Hekw8JnbcqVQMi9T0yVuRo8lrX2xCfZcwc2FCVkIEiQ ansible
The key's randomart image is:
+--[ED25519 256]--+
|      E.*.=o=B===|
|       + X =+O+o+|
|        X + Bo= =|
|         @ *. .=.|
|        S *    . |
|         o       |
|                 |
|                 |
|                 |
+----[SHA256]-----+
```
```bash
dmahfuzd@EAI-MAHFUZ:~/.ssh$ ssh -i ~/.ssh/ansible eai@172.16.16.100
Last login: Wed Dec  6 15:29:50 2023 from 172.16.16.1
[eai@kmaster ~]$
```

Make Default SSH Key

The default SSH key for authentication instead of specifying a specific key file using the -i option, we need to make sure that your default SSH key is located in the default location, which is usually ~/.ssh/id_rsa for the private key and ~/.ssh/id_rsa.pub for the public key.

Here's how can SSH into a remote server without specifying the key file:

```bash
ssh eai@172.16.16.100
```
Make sure that default SSH key pair is available in the ~/.ssh/ directory with the default filenames (id_rsa for the private key and id_rsa.pub for the public key). If keys have different filenames, specify the key using the -i option as you did in your original command.

If don't have a default key pair or want to use a different key pair, add the key to the SSH agent using the ssh-add command:

```bash
ssh-add ~/.ssh/your_private_key
```
Replace your_private_key with the actual filename of private key. After adding the key to the agent, should be able to SSH into the remote server without specifying the key file in the command.

If getting following error after run command then need to start the SSH Agent
```bash
ssh-add ~/.ssh/ansible

Could not open a connection to your authentication agent.
```

The error message "Could not open a connection to your authentication agent" suggests that the SSH agent is not running or not properly configured.

Here are the steps to resolve this issue:

Start the SSH Agent:

Run the following command to start the SSH agent:
```bash
eval "$(ssh-agent -s)"
```
This command starts the SSH agent and prints the necessary environment variables.

Add the SSH Key to the Agent:

Run the following command to add your SSH key to the agent:
```bash
ssh-add ~/.ssh/ansible
```
Replace ~/.ssh/ansible with the actual path to your private key.

Check SSH Agent:

Verify that your key has been added to the SSH agent by running:
```bash
ssh-add -L
```
This command should display the public key if it's successfully added.

Now, you should be able to use the ssh command without specifying the key file:
```bash
ssh eai@172.16.16.100
```
If you encounter issues, ensure that the SSH agent is running and that your private key is added to it. If you're using a graphical desktop environment, the SSH agent may start automatically. In that case, you can check if the SSH agent is running by using:
```bash
echo $SSH_AUTH_SOCK
```

Ansible Command
---------------
Ansible Ad-Hoc Command
```bash
ansible -i 172.16.16.101, -m ping all -u eai
```
Ansible Ad-Hoc Command with key file
```bash
ansible --key-file ~/.ssh/ansible -i 172.16.16.101, -m ping all -u eai
```
```bash    
72.16.16.101 | SUCCESS => {
"ansible_facts": {
    "discovered_interpreter_python": "/usr/libexec/platform-python"
},
"changed": false,
"ping": "pong"
}
```

Install Python and Other Dependencies Using Ansible Ad-Hoc Commands
```bash
ansible -i /mnt/d/DevOps/GitHub/DevOps/Infrastructure_as_code/Ansible/Testing/Local/Inventory/inventory.yaml -u eai -b --ask-become-pass -m yum -a 'name=python3-setuptools state=present'
```

Store inventory and ssh key file ansible.cfg

- Create ansible.cfg file and following command
```bash
[defaults]
inventory = ./mnt/d/DevOps/GitHub/DevOps/infrastructure_as_code/ansible/testing/local/inventories/inventory.yaml
private_key_file = ~/.ssh/ansible
```
```bash
export ANSIBLE_CONFIG=./ansible.cfg
```

To set the ANSIBLE_CONFIG environment variable permanently, you can add the export command to your shell profile file. The specific file depends on the shell you are using. Here are examples for the two most common shells: Bash and Zsh.

Bash:
Open your Bash profile file with a text editor. This file is usually ~/.bashrc or ~/.bash_profile.


```bash
vim ~/.bashrc
```
Add the following line at the end of the file:
```bash
export ANSIBLE_CONFIG=/home/eai/shared/infrastructure_as_code/ansible/testing/local
```

Save the file and exit the text editor.

To apply the changes, either restart your terminal or run:


```bash
source ~/.bashrc
```



Building an Inventory
Inventories organize managed nodes in centralized files that provide Ansible with system information and network locations. Using an inventory file, Ansible can manage a large number of hosts with a single command.

Sample inventory.yaml File
Create an inventory.yaml file to define agent information:

```yaml
kubernetesnodes:
  hosts:
    kmaster:
      ansible_host: 172.16.16.100
    kworker1:
      ansible_host: 172.16.16.101
    kworker2:
      ansible_host: 172.16.16.102

kubernetesmaster:
  hosts:
    kmaster:
      ansible_host: 172.16.16.100

kubernetworkers:
  hosts:
    kworker1:
      ansible_host: 172.16.16.101
    kworker2:
      ansible_host: 172.16.16.102
```

Check inventory host list
```bash
ansible all --list-hosts
```

```bash
ansible-inventory --list
```


Test the Inventory with Ad-Hoc command
```bash
ansible --key-file ~/.ssh/ansible  clusternodes -u eai -m ping -i /mnt/d/DevOps/GitHub/DevOps/infrastructure_as_code/ansible/testing/local/inventories/inventory.yaml

ansible clusternodes -u eai -m ping -i /mnt/d/DevOps/GitHub/DevOps/infrastructure_as_code/ansible/testing/local/inventories/inventory.yaml

ansible clusternodes -u eai -m ping

ansible --key-file ~/.ssh/ansible clusternodes -u eai -b --ask-become-pass -m ping -i /mnt/d/DevOps/GitHub/DevOps/Infrastructure_as_code/Ansible/Testing/Local/Inventory/inventory.yaml

ansible clusternodes -u eai -m ping -i /mnt/d/DevOps/GitHub/DevOps/Infrastructure_as_code/Ansible/Testing/Local/Inventory/inventory.yaml
```

Check the Inventory
```bash
ansible-inventory -i /mnt/d/DevOps/GitHub/DevOps/Infrastructure_as_code/Ansible/Testing/Local/Inventory/inventory.yaml --list
```
```bash
ansible-inventory --list
```

Install Package with Ad-Hoc command
```bash
ansible clusternodes -i /mnt/d/DevOps/GitHub/DevOps/Infrastructure_as_code/Ansible/Testing/Local/Inventory/inventory.yaml -u eai -b --ask-become-pass -m yum -a 'name=python3-setuptools state=present'
```

Playbook Usage
```bash
ansible-playbook -i /mnt/d/DevOps/GitHub/DevOps/infrastructure_as_code/ansible/testing/local/inventories/inventory.yaml /mnt/d/DevOps/GitHub/DevOps/infrastructure_as_code/ansible/testing/local/playbooks/playbook.yaml -u eai
```
```bash
ansible-playbook /mnt/d/DevOps/GitHub/DevOps/infrastructure_as_code/ansible/testing/local/playbooks/playbook.yaml -u eai
```
```bash
ansible-playbook /mnt/d/DevOps/GitHub/DevOps/infrastructure_as_code/ansible/testing/local/playbooks/playbook.yaml -u eai
```
Playbook run without specifying the full paths

In ansible.cfg file, can use the roles_path configuration to specify the directory where Ansible should look for roles. Additionally, can use the inventory configuration to set the default inventory file.

Here's an example of how ansible.cfg might look:

```bash
[defaults]
roles_path = /mnt/d/DevOps/GitHub/DevOps/infrastructure_as_code/ansible/testing/local/roles
inventory = /mnt/d/DevOps/GitHub/DevOps/infrastructure_as_code/ansible/testing/local/inventories/inventory.yaml
private_key_file = ~/.ssh/ansible
```
With this configuration, can run playbook without specifying the full paths:

```bash
ansible-playbook playbooks/playbook.yaml -u eai
```
```bash
ansible-playbook playbooks/playbook.yaml -u eai -b --ask-become-pass
```







