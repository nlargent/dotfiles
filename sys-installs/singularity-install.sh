#!/bin/bash

# Check for root privileges (aka EUID == 0)
if [[ $(id -u) -ne 0 ]]; then
    echo "This script requires root (sudo) privileges. Please run with sudo or as root."
    exit 1
fi

# Check if apt is on the system
if ! command -v apt &> /dev/null; then
    echo "This script requires 'apt' as the package manager, but it was not found on your system."
    exit 1
fi

# Ask to install
echo "This script will install Singularity"
echo "Do you want to continue? (y/n)"

# User input to confirm install
read -r user_input
if [[ "$user_input" != "y" ]]; then
    echo "Installation canceled."
    exit 0
fi

# Check for name conflicts
SOFTWARE_NAME="singularity"
if dpkg-query -W -f='${Status}' $SOFTWARE_NAME 2>/dev/null | grep -q "install ok installed"; then
    echo "A package with the name '$SOFTWARE_NAME' is already installed or exists."
    exit 1
fi

# Install Singularity
echo "Installing Singularity..."
apt update
apt install -y singularity-container

echo "Installation complete."
echo "You can now use Singularity. To test it, run the following command:"
echo "singularity --version"

