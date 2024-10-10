<h2 align="center">
Kafka Setup and Usage Documentation
</h2>

Vagrant Commands Cheat Sheet
Initialization:

vagrant init <box>: Initializes a new Vagrant environment using a specified box.
vagrant box add <box-name>: Adds a box to your Vagrant installation.
Configuration:

vagrant up: Starts the virtual machine defined in the Vagrantfile.
vagrant reload: Restarts the virtual machine, applying any changes in the Vagrantfile.
vagrant suspend: Suspends the virtual machine (saves its state to disk).
vagrant halt: Stops the virtual machine (poweroff).
vagrant destroy: Stops and deletes all traces of the virtual machine.
Status and Information:

vagrant status: Displays the status of the virtual machine(s).
vagrant global-status: Displays the status of all Vagrant environments on the system.
SSH Access:

vagrant ssh: Connects to the virtual machine via SSH.
vagrant ssh-config: Outputs OpenSSH valid configuration to connect to the machine.
Provisioning:

vagrant provision: Reruns the provisioning scripts defined in the Vagrantfile.
Plugin Management:

vagrant plugin install <plugin-name>: Installs a Vagrant plugin.
vagrant plugin list: Lists installed plugins.
vagrant plugin uninstall <plugin-name>: Uninstalls a Vagrant plugin.
Box Management:

vagrant box list: Lists all installed boxes.
vagrant box update: Updates the installed base boxes to the latest version.
Networking:

vagrant port: Displays information about guest ports forwarded to the host.
Miscellaneous:

vagrant version: Displays the Vagrant version.
vagrant global-status --prune: Removes invalid/inaccessible machines from the global status.
Vagrantfile Editing:

Vagrantfile is where you define your machine configurations. Edit it as needed.
vagrant edit: Opens the Vagrantfile in the default editor.
Example Usage:
Create and Start a Virtual Machine:

```bash
vagrant init ubuntu/bionic64
vagrant up
```
SSH into the Virtual Machine:
```bash
vagrant ssh
```

Suspend and Resume:

```bash
vagrant suspend
vagrant resume
```
Destroy and Recreate:

```bash
vagrant destroy
vagrant up
```
Provisioning:
```bash
vagrant provision
```
Plugin Management:

```bash
vagrant plugin install <plugin-name>
vagrant plugin list
vagrant plugin uninstall <plugin-name>
```