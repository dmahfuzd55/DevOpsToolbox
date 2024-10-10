
#!/bin/bash

# Check Redis Installation:
redis-server --version

# Access Redis Database without Password:
redis-cli

# Access Redis Database with Password:
redis-cli -a your_redis_password

# Check Redis Server Information:
INFO

# Retrieve information about Redis server
redis-cli INFO server

# Retrieve top 5 keys
redis-cli --raw KEYS '*' | head -n 5

# Administrative Commands:
# Some administrative commands can help in managing the Redis server, such as:

CONFIG GET # Retrieve the value of a configuration parameter.
CONFIG SET # Set a configuration parameter's value.
PING       # Check if the server is running.
FLUSHALL   # Delete all keys from all databases.


