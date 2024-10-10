<h2 align="center">
MongodDB Command and Usage Documentation
</h2>

### MongoDB Installation

# MongoDB Official Documentation

MongoDB official website: [MongoDB official website](https://www.mongodb.com/docs/manual/tutorial/install-mongodb-on-red-hat/#uninstall-mongodb-community-edition)

MongoDB Disable Transparent Huge Pages: [Disable Transparent Huge Pages (THP)](https://www.mongodb.com/docs/manual/tutorial/transparent-huge-pages/)

DigitalOcean webstie: [How To Install MongoDB on CentOS 8](https://www.digitalocean.com/community/tutorials/how-to-install-mongodb-on-centos-8)

MongoDB is a popular NoSQL database. Follow these steps to install MongoDB on Ubuntu or Debian-based systems.

#### Step 1 – Adding the MongoDB Repository
The mongodb-org package does not exist within the default repositories for CentOS. However, MongoDB maintains a dedicated repository. Let’s add it to our server.

With the vi editor, create a .repo file for yum, the package management utility for CentOS:
```bash
sudo vim /etc/yum.repos.d/mongodb-org-7.0.repo
```

Then, visit the Install on Red Hat section of MongoDB’s documentation and add the repository information for the latest stable release to the file:
```bash
[mongodb-org-7.0]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/8/mongodb-org/7.0/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://pgp.mongodb.com/server-7.0.asc
```

Save the changes to the file by pressing the ESC key, then type :wq, and hit ENTER.

Before continuing, you should verify that the MongoDB repository exists within the yum utility. The repolist command displays a list of enabled repositories:
```bash
yum repolist
```

#### Step 2 – Installing MongoDB

You can install the mongodb-org package from the third-party repository using the yum utility.
```bash
sudo yum install -y mongodb-org
```

Alternatively, to install a specific release of MongoDB, specify each component package individually and append the version number to the package name, as in the following example:
```bash
sudo yum install -y mongodb-org-7.0.5 mongodb-org-database-7.0.5 mongodb-org-server-7.0.5 mongodb-mongosh-7.0.5 mongodb-org-mongos-7.0.5 mongodb-org-tools-7.0.5
```

**NOTE:**
yum automatically upgrades packages when newer versions become available. If you want to prevent MongoDB upgrades, pin the package by adding the following exclude directive to your /etc/yum.conf file:
```bash
exclude=mongodb-org,mongodb-org-database,mongodb-org-server,mongodb-mongosh,mongodb-org-mongos,mongodb-org-tools
```

### Directory Paths

#### To Use Default Directories
By default, MongoDB runs using the `mongod` user account and uses the following default directories:

```bash
/var/lib/mongo   # the data directory
/var/log/mongodb  # the log directory
```
The package manager creates the default directories during installation. The owner and group name are mongod.

#### To Use Non-Default Directories
To use a data directory and/or log directory other than the default directories:

1. Create the new directory or directories.

2. Edit the configuration file /etc/mongod.conf and modify the following fields accordingly:

storage.dbPath to specify a new data directory path (e.g., /some/data/directory)
systemLog.path to specify a new log file path (e.g., /some/log/directory/mongod.log)

3. Ensure that the user running MongoDB has access to the directory or directories:
```bash
sudo chown -R mongod:mongod <directory>
```
If you change the user that runs the MongoDB process, you must give the new user access to these directories.

4. Configure SELinux if enforced. See Configure SELinux.


### Configure SELinux

Starting in MongoDB 5.0, a new SELinux policy is available for MongoDB installations that:

- Use an .rpm installer.
- Use default configuration settings.
- Run on RHEL7 or later.

For MongoDB Enterprise installations that use LDAP authentication, the following additional SELinux policies must be in place:

- For deployments that use LDAP authentication via OS libraries, MongoDB must have access to the `tcontext=system_u:object_r:ldap_port_t:s0` LDAP ports. You can enable access by running `setsebool -P authlogin_nsswitch_use_ldap 1`.
- For deployments that use LDAP authentication via `saslauthd`, you must enable cluster mode by running `sudo setsebool -P daemons_enable_cluster_mode 1`.

If your installation does not meet these requirements, refer to the SELinux Instructions for .tgz packages.

**NOTE:**
If your MongoDB deployment uses custom settings for any of the following:

- MongoDB connection ports
- dbPath
- systemLog.path
- pidFilePath

You cannot use the MongoDB supplied SELinux policy. An alternative is to create a custom SELinux policy, however, an improperly written custom policy may be less secure or may stop your `mongod` instance from working.

 Install the SELinux Policy

1. Ensure you have the following packages installed:

- git
- make
- checkpolicy
- policycoreutils
- selinux-policy-devel

```bash
sudo yum install git make checkpolicy policycoreutils selinux-policy-devel
```

2. Download the policy repository.
```bash
git clone https://github.com/mongodb/mongodb-selinux
```
3. Build the policy.
```bash
cd mongodb-selinux
make
```

Apply the policy.
```bash
sudo make install
```


**IMPORTANT:**
Backward-Incompatible Feature
Starting in MongoDB 5.1, you must run the following command from the directory into which the SELinux policy was previously cloned before you can downgrade to an earlier MongoDB version:
```bash
sudo make uninstall
```

# SELinux Policy Considerations

The SELinux policy is designed to work with the configuration that results from a standard MongoDB `.rpm` package installation. See [standard installation assumptions](#) for more details.

The SELinux policy is designed for `mongod` servers. It does not apply to other MongoDB daemons or tools such as:

- `mongos`
- `mongosh`

## Install and Configure `mongocryptd` for CSFLE

The [reference policy](#) supplied by the SELinux Project includes a `mongodb_admin` macro. This macro is not included in the MongoDB SELinux policy. An administrator in the `unconfined_t` domain can manage `mongod`.

To uninstall the policy, go to the directory where you downloaded the policy repository and run:

```bash
sudo make uninstall
```


### Procedure

Follow these steps to run MongoDB Community Edition on your system. These instructions assume that you are using the default settings.

#### Init System

To run and manage your `mongod` process, you will be using your operating system's built-in init system. Recent versions of Linux tend to use `systemd` (which uses the `systemctl` command), while older versions of Linux tend to use System V init (which uses the `service` command).

If you are unsure which init system your platform uses, run the following command:

```bash
ps --no-headers -o comm 1
```

1 Start MongoDB.
You can start the mongod process by issuing the following command:
```bash
sudo systemctl start mongod
```
If you receive an error similar to the following when starting mongod:

Failed to start mongod.service: Unit mongod.service not found.

Run the following command first:
```bash
sudo systemctl daemon-reload
```
Then run the start command above again.

2 Verify that MongoDB has started successfully.
You can verify that the mongod process has started successfully by issuing the following command:
```bash
sudo systemctl status mongod
```
You can optionally ensure that MongoDB will start following a system reboot by issuing the following command:
```bash
sudo systemctl enable mongod
```
3 Stop MongoDB.
As needed, you can stop the mongod process by issuing the following command:
```bash
sudo systemctl stop mongod
```
4 Restart MongoDB.
You can restart the mongod process by issuing the following command:
```bash
sudo systemctl restart mongod
```
You can follow the state of the process for errors or important messages by watching the output in the /var/log/mongodb/mongod.log file.

5 Begin using MongoDB.
Start a mongosh session on the same host machine as the mongod. You can run mongosh without any command-line options to connect to a mongod that is running on your localhost with default port 27017.
```bash
mongosh
```
For more information on connecting using mongosh, such as to connect to a mongod instance running on a different host and/or port, see the mongosh documentation.

To help you start using MongoDB, MongoDB provides Getting Started Guides in various driver editions. For the driver documentation, see 
Start Developing with MongoDB.




-------------------------

### Mongodb Installation

Follow the official website and digitalocean website to install mongodb.

### Mongodb Security

To enhance the security of MongoDB beyond just changing the default port, you can implement authentication to require username and password authentication for all connections. Here's how you can do it:

Enable MongoDB Authentication:

Open the MongoDB configuration file /etc/mongod.conf:
```bash
sudo nano /etc/mongod.conf
```bash
Find the security section and uncomment (remove the #) the authorization setting. If it's not there, add the following line:
```bash
security:
  authorization: enabled
```
This setting will require all clients to authenticate themselves.

Create MongoDB Administrative User:

You need to create an administrative user with the ability to manage databases and users. Connect to your MongoDB instance:
```bash
mongo --host localhost --port 27017
```
Switch to the admin database:
```bash
use admin
```
Create an administrative user with a username and password. Replace <admin_user> and <password> with your desired values:
```
db.createUser({user: "<admin_user>", pwd: "<password>", roles: ["root"]})
```
Make sure to remember these credentials as they will be used to authenticate.

Restart MongoDB:

After making changes to the MongoDB configuration, restart the MongoDB service:
```bash
sudo systemctl restart mongod
```
Access MongoDB with Authentication:

Now, when you connect to MongoDB, you need to authenticate with the administrative user you created.
```bash
mongo --host localhost --port 27017 -u <admin_user> -p
```


### Mongodb access from outside

Making MongoDB accessible from outside your server involves similar steps to those for Redis, with configuration adjustments and potential firewall modifications. Here's how you can do it:

Update MongoDB Configuration:

By default, MongoDB is configured to listen only to connections from localhost for security reasons. You need to modify the MongoDB configuration file /etc/mongod.conf to allow external connections.

Open the MongoDB configuration file in a text editor:
```bash
sudo nano /etc/mongod.conf
```
Find the net section, which should look like this:
```bash
net:
  port: 27017
  bindIp: 127.0.0.1
```
Change the bindIp value to your server's IP address or 0.0.0.0 to listen on all network interfaces:
```bash
net:
  port: 27017
  bindIp: 0.0.0.0  # or your_server_ip
```
Save the changes and exit the text editor.

Configure Firewall:

If you have a firewall enabled on your server, you need to open the MongoDB port (default is 27017) to allow external connections.

For example, if you're using firewalld, you can open the MongoDB port with the following commands:
```
sudo firewall-cmd --zone=public --add-port=27017/tcp --permanent
sudo firewall-cmd --reload
```
Replace 27017 with your MongoDB port if you've configured a different one.

Restart MongoDB:

After making changes to the MongoDB configuration, restart the MongoDB service for the changes to take effect:
```bash
sudo systemctl restart mongod
```
Access MongoDB from External Clients:

You should now be able to access MongoDB from external clients using the server's IP address or hostname and the MongoDB port (default is 27017).

For example, if your server's IP address is 192.168.1.100, you can connect to MongoDB from an external client using:
```bash
mongo --host 192.168.1.100 --port 27017
```











