#!/bin/bash

# Function to display a separator line
separator() {
    echo "====================================="
}

# Function to install Redis
install_redis() {
    separator
    echo "Installing Redis..."
    sudo yum install redis -y
    sudo systemctl start redis
    sudo systemctl enable redis
    echo "Redis installed and started successfully."
    separator
}

# Function to install RedisInsight
install_redis_insight() {
    separator
    echo "Installing RedisInsight..."
    # Download RedisInsight binary
    wget -O redisinsight.tar.gz "https://downloads.redis.io/redisinsight/releases/redisinsight-1.6.3-linux-x86_64.tar.gz"
    # Check if the download was successful
    if [ $? -eq 0 ]; then
        # Extract RedisInsight
        tar -xzvf redisinsight.tar.gz
        # Move RedisInsight to a suitable location
        sudo mv redisinsight-* /opt/redisinsight
        # Clean up
        rm redisinsight.tar.gz
        echo "RedisInsight installed successfully."
    else
        echo "Failed to download RedisInsight. Please check your internet connection and try again."
    fi
    separator
}

# Main function
main() {
    install_redis
    install_redis_insight
}

# Call the main function
main