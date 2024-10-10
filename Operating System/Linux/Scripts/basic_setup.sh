#!/bin/bash

# Function to display a separator line
separator() {
    echo "====================================="
}

# Function to display basic OS info
os_info() {
    separator
    echo "Operating System Information:"
    uname -a
    separator
    cat /etc/os-release
    separator
}

# Function to display memory info
memory_info() {
    separator
    echo "Memory Information:"
    free -h
    separator
}

# Function to display storage info
storage_info() {
    separator
    echo "Storage Information:"
    df -h
    separator
}

# Function to display network interface info
network_info() {
    separator
    echo "Network Information:"
    ip addr show
    separator
}

# Main function
main() {
    os_info
    memory_info
    storage_info
    network_info
}

# Call the main function
main