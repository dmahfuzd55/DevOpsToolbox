### **How to Connect with remote pc from windows with ssh**

#### **Step 1: Generate SSH Key Pair**
Open a Command Prompt on your Windows machine.****

Run the following command to generate an SSH key pair:
```bash
ssh-keygen -t rsa -b 2048
```

Follow the prompts to set a location for the keys (press Enter to accept the default) and optionally set a passphrase.

This will create a private key file (usually id_rsa) and a corresponding public key file (usually id_rsa.pub) in the %userprofile%\.ssh directory.

#### **Step 2: Transfer Public Key to Remote PC**
Use a tool like scp (secure copy) to transfer the public key to your remote PC. Open a Command Prompt and run:

```bash
scp %userprofile%\.ssh\id_rsa.pub eai@172.16.16.101:~/.ssh

scp C:\Users\Administrator\.ssh\id_rsa.pub eai@172.16.16.100:~/.ssh
```

Replace %userprofile% with the actual path to your user profile directory.

This command copies the public key to the ~/.ssh/ directory on your remote PC.

Connect to your remote PC using SSH:

```
ssh eai@172.16.16.101
```

Enter the password for the eai user when prompted.

Append the public key to the authorized_keys file:

```
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
```

This command appends the contents of the public key to the authorized_keys file.

#### **Step 3: Connect Using Visual Studio Code**
Install the "Remote - SSH" extension in Visual Studio Code.

Open the Command Palette (press Ctrl+Shift+P) and select "Remote-SSH: Connect to Host."

Enter the SSH connection string: eai@172.16.16.101.

VS Code will prompt you for the password for the eai user.

Once connected, you'll be working on your remote PC within VS Code.
