### SSH Overview and Setup

Setup secure ssh key with password

```bash
ssh-keygen -t ed25519 -C "Key with password"

Generating public/private ed25519 key pair.
Enter file in which to save the key (/home/dmahfuzd/.ssh/id_ed25519): 
Enter passphrase (empty for no passphrase): //Enter Password 
Enter same passphrase again: 
Your identification has been saved in /home/dmahfuzd/.ssh/id_ed25519
Your public key has been saved in /home/dmahfuzd/.ssh/id_ed25519.pub
The key fingerprint is:
SHA256:by9dLBgFy0bmPtvjknaOZX/r5Mx36CuaM9aGoZhnSf4 Key generate with key type
The key's randomart image is:
+--[ED25519 256]--+
|          +.     |
|         = ..    |
|          =.     |
|         o.      |
|        S oo .   |
|        ..o+. o  |
|       = o+*=o o |
|      o *.XB*o* +|
|       o +EX+o=O+|
+----[SHA256]-----+ 
```
```bash
ls -la ~/.ssh

total 28
drwx------ 2 dmahfuzd dmahfuzd 4096 Dec  6 20:43 .
drwxr-x--- 6 dmahfuzd dmahfuzd 4096 Dec  2 12:03 ..
-rw------- 1 dmahfuzd dmahfuzd  464 Dec  6 20:43 id_ed25519
-rw-r--r-- 1 dmahfuzd dmahfuzd  108 Dec  6 20:43 id_ed25519.pub
-rw------- 1 dmahfuzd dmahfuzd 2602 Nov  8 12:59 id_rsa
-rw-r--r-- 1 dmahfuzd dmahfuzd  573 Nov  8 12:59 id_rsa.pub
-rw-r--r-- 1 dmahfuzd dmahfuzd 1984 Dec  5 23:30 known_hosts
```
```bash
dmahfuzd@EAI-MAHFUZ:/mnt/d$ cat ~/.ssh/id_ed25519.pub

ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAsZx3Ak2b9AFONazPLE85/nsUL+3QemeRhFv9IB3Psj Key with password
```
```bash
ssh-copy-id -i ~/.ssh/id_ed25519.pub eai@172.16.16.100

/usr/bin/ssh-copy-id: INFO: Source of key(s) to be installed: "/home/dmahfuzd/.ssh/id_ed25519.pub"
/usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
/usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys
eai@172.16.16.100's password: 

Number of key(s) added: 1

Now try logging into the machine, with:   "ssh 'eai@172.16.16.100'"
and check to make sure that only the key(s) you wanted were added.
```
```bash
ssh eai@172.16.16.100

Enter passphrase for key '/home/dmahfuzd/.ssh/id_ed25519': 
Last login: Wed Dec  6 14:36:45 2023 from 172.16.16.1
[eai@kmaster ~]$
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

Default SSH Key

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
If it's set, the agent is running, and you can proceed with adding the key using ssh-add.