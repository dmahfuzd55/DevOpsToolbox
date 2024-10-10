<h2 align="center">
Rancher Cluster Command and Usage Documentation
</h2>

#### How rancher cluster use with kubectl in local computer

### Windows

Install kubectl

Install on windows

To install kubectl on Windows, you can use the official Kubernetes release or a package manager like Chocolatey. Here are instructions for both methods:

Method 1: Downloading from Kubernetes Release
Download the latest version of kubectl from the official Kubernetes GitHub repository:

Go to the releases page: https://github.com/kubernetes/kubernetes/releases
Find the latest release and download the kubectl binary for Windows. Look for a file named kubectl.exe.
Place the downloaded kubectl.exe in a directory included in your system's PATH.

kubectl.exe file directory is following
```bash
C:\Windows
```

Add this direcotry with environment variable to run command from anywhere

Open a new command prompt or PowerShell window and test kubectl:

```bash
kubectl version
```

Method 2: Using Chocolatey
Install Chocolatey if you haven't already. Open a PowerShell session with administrator privileges and run:

```bash
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
```

Install kubectl using Chocolatey:

```bash
choco install kubernetes-cli
```

Once the installation is complete, open a new command prompt or PowerShell window and test kubectl:

```bash
kubectl version
```

First download KubeConfig file from rancher cluster

Then run following command to check KubeConfig file

```bash
kubectl --kubeconfig 'E:\My Drive\DevOps\Office\DevOps\Cloud\Kubernetes\jblecs.yaml' get nodes
```

To create a shortcut or alias for your kubeconfig file path, you can use environment variables or create a variable in your shell profile. Assuming you are using PowerShell on Windows, you can add the following line to your PowerShell profile:

```bash
$env:KUBECONFIG = 'E:\My Drive\DevOps\Office\DevOps\Cloud\Kubernetes\jblecs.yaml'
```

Windows: Permanently set KUBECONFIG

To set environment variables graphically in Windows, you can use the following steps:

 1. Open Control Panel: Press Win + R to open the Run dialog, type control, and press Enter. Alternatively, you can search for "Control Panel" in the Start menu and open it.

 2. Navigate to System: In Control Panel, click on "System and Security", then click on "System".

 3. Open Advanced System Settings: On the left-hand side, click on "Advanced system settings". This will open the System Properties window.

 4. Access Environment Variables: In the System Properties window, click on the "Environment Variables..." button.

 5. Add or Edit System Variable: In the Environment Variables window, under the "System variables" section, click on the "New..." button if you want to add a new environment variable, or select the existing KUBECONFIG variable and click on the "Edit..." button to modify it.

 6. Enter Variable Name and Value: Enter KUBECONFIG as the variable name and D:\DevOps\Office\DevOps\Kubernetes\Local\jblkubdev.yaml as the variable value.

 7. Click OK: Click "OK" to close the Environment Variables window and save the changes.

Restart Your System: To ensure the changes take effect, it's recommended to restart your system. However, you can also log out and log back in, or open a new command prompt or PowerShell window to apply the changes.


This sets the KUBECONFIG environment variable to the specified file path. After setting this environment variable, you can use kubectl commands without specifying the --kubeconfig flag, and it will automatically use the configured kubeconfig file:




### Linux

#### Install kubectl ubuntu




Linux: Permanently set KUBECONFIG

To set the KUBECONFIG environment variable permanently in Ubuntu, you can add it to your shell configuration file, such as .bashrc or .bash_profile. Here's how you can do it:

Open your shell configuration file using a text editor. For example, you can use nano:
```bash
nano ~/.bashrc
```
Add the following line to the end of the file:
```bash
export KUBECONFIG="/mnt/d/DevOps/Office/DevOps/Kubernetes/Local/jblkubdev.yaml"
```
Save the file and exit the text editor. If you're using nano, you can do this by pressing Ctrl + X, then Y, and finally Enter.

To apply the changes immediately, you can either close and reopen your terminal or run the following command:

```bash
source ~/.bashrc
```

```bash
 mkdir -p $HOME/.kube
 sudo cp /mnt/d/DevOps/Office/DevOps/Kubernetes/Local/config/rancher-cluster/jblcls-dev.yaml ~/.kube/config
 sudo chown $(id -u):$(id -g) $HOME/.kube/config
```



```bash
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
scp root@172.16.16.100:/etc/kubernetes/admin.conf ~/.kube/config  // copy from rempote server
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```



Now, the KUBECONFIG environment variable will be set permanently, and you can use kubectl commands without specifying the --kubeconfig flag each time. For example:


```bash
kubectl get nodes
```


### Rancher node add

Remove Kubernetes Directories:

```bash
sudo rm -rf /etc/kubernetes/
sudo rm -rf /var/lib/etcd/
sudo rm -rf /var/lib/kubelet/

sudo rm -rf /etc/cni
sudo rm -rf /opt/cni


sudo apt-get autoremove -y
sudo apt-get autoclean -y

sudo reboot
```

#### Registration Command

Run this command on each of the existing Linux machines you want to register.


```bash
sudo docker run -d --privileged --restart=unless-stopped --net=host -v /var/lib/longhorn/kubernetes-rancher/kubernetes:/etc/kubernetes -v /var/run:/var/run  rancher/rancher-agent:v2.8.2 --server https://172.30.38.20 --token sm9vhhmvjgfgsk2d2n5ztg8d7lrc6s8v82q7tjtbw9khcsfhd9dctq --ca-checksum 5074a52c90892364149a657b1057904a38e7297931de33a11fd6dfa3f58be8ba --worker


sudo docker run -d --privileged --restart=unless-stopped --net=host -v /u01/kubernetes-rancher/kubernetes:/etc/kubernetes -v /var/run:/var/run  rancher/rancher-agent:v2.8.2 --server https://172.30.38.20 --token sm9vhhmvjgfgsk2d2n5ztg8d7lrc6s8v82q7tjtbw9khcsfhd9dctq --ca-checksum 5074a52c90892364149a657b1057904a38e7297931de33a11fd6dfa3f58be8ba --worker
```
