#!/bin/bash

# Function to display a separator line
separator() {
    echo "====================================="
}

# Function to update Redis configuration
update_redis_config() {
    separator
    echo "Updating Redis configuration..."
    
    # Set custom port
    sed -i 's/^port [0-9]\+$/port 7474/' /etc/redis.conf # Replace '6379' with your desired port number

    # Set custom log file
    sed -i 's/^logfile .*/logfile \/var\/log\/redis\/redis.log/' /etc/redis.conf # Replace '/var/log/redis/redis.log' with your desired log file path

    # Enable password authentication
    sed -i "s/^# requirepass foobared$/requirepass Eai@4567/" /etc/redis.conf # Replace 'your_password_here' with your desired password

    echo "Redis configuration updated successfully."
    separator
}

# Function to restart Redis service
restart_redis_service() {
    separator
    echo "Restarting Redis service..."
    sudo systemctl restart redis
    echo "Redis service restarted."
    separator
}

# Main function
main() {
    update_redis_config
    restart_redis_service
}

# Call the main function
main