<h2 align="center">
Linux Command and Usage Documentation
</h2>

To install Redis on Red Hat Enterprise Linux 8 and configure it to use both the default port (6379) and an alternative port with and without a password, you can follow these steps:

Install Redis:

First, you need to install Redis on your Red Hat Linux 8 system. Redis is available in the default repositories, so you can use the package manager (dnf) to install it:
```bash
sudo dnf install redis
```
Configure Redis with Default Port:

By default, Redis will be configured to use port 6379. You can verify this in the Redis configuration file located at /etc/redis.conf. The default configuration usually doesn't have authentication enabled.

If you want to use Redis without a password on the default port, you don't need to make any changes. Redis will be accessible without authentication.

Configure Redis with Alternative Port:

If you want to configure Redis to listen on an alternative port, say 6380, and optionally enable password authentication for it, follow these steps:

Open the Redis configuration file /etc/redis.conf in a text editor:
```bash
sudo nano /etc/redis.conf
```
Find the line that starts with port, uncomment it if it's commented out, and change the port number to the desired alternative port, for example:
```bash
port 6380
```
To enable password authentication, find the line that starts with # requirepass, uncomment it, and set your desired password:
```bash
requirepass your_password_here
```
Replace your_password_here with your desired password.

Save the changes and exit the text editor.
Restart Redis:

After making the necessary configuration changes, you need to restart the Redis service for the changes to take effect:
```
sudo systemctl restart redis
```
Verify Redis Configuration:

You can verify that Redis is running on both the default and alternative ports by using the redis-cli command-line interface tool:

# Default Port (without password)
```bash
redis-cli -h localhost -p 6379
```

# Alternative Port (with password)
```bash
redis-cli -h localhost -p 6380 -a your_password_here
```


### Redis accessible from outside

To make Redis accessible from outside your server, you'll need to modify its configuration to allow external connections and potentially configure firewall settings to permit traffic on the Redis port. Here's how you can do it:

Update Redis Configuration:

By default, Redis is configured to only listen for connections from localhost for security reasons. To allow external connections, you need to modify the Redis configuration file /etc/redis.conf.

Open the Redis configuration file in a text editor:
```bash
sudo nano /etc/redis.conf
```
Find the line that starts with bind and change it to:
```bash
bind 0.0.0.0
```
This will make Redis listen to connections from all network interfaces.

Additionally, if you have set up a password for Redis, make sure to replace # requirepass with:
```bash
requirepass your_password_here
```
Save the changes and exit the text editor.

Configure Firewall:

If you have a firewall enabled on your server (such as firewalld or iptables), you need to open the Redis port to allow external connections.

For example, if you're using firewalld, you can open the Redis port (default 6379) with the following commands:
```bash
sudo firewall-cmd --zone=public --add-port=6379/tcp --permanent
sudo firewall-cmd --reload
```
Replace 6379 with your Redis port if you've configured a different one.

Restart Redis:

After making changes to the Redis configuration, restart the Redis service for the changes to take effect:
```bash
sudo systemctl restart redis
```
Access Redis from External Clients:

You should now be able to access Redis from external clients using the server's IP address or hostname and the Redis port (default is 6379).

For example, if your server's IP address is 192.168.1.100, you can connect to Redis from an external client using:
```bash
redis-cli -h 192.168.1.100 -p 6379
```
If you've configured a password, include the -a option followed by the password:
```bash
redis-cli -h 192.168.1.100 -p 6379 -a your_password_here
```

