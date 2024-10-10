#!/bin/bash

# Function to display a separator line
separator() {
    echo "====================================="
}

# Function to set the hostname
set_hostname() {
    separator
    echo "Setting up hostname..."
    read -p "Enter the new hostname: " new_hostname
    hostnamectl set-hostname "$new_hostname"
    echo "Hostname set to: $new_hostname"
    separator
}

# Main function
main() {
    set_hostname
}

# Call the main function
main