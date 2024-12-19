#!/bin/bash

# Script Name: setup_kali_env.sh
# Description: Self-contained script to update and upgrade Kali Linux, install avahi-daemon, install Tailscale,
#              enable SSH, configure SSH keys, and set a new hostname.

# Self-contained logic for downloading, running, and cleaning up
if [ "$0" != "/bin/bash" ]; then
    # Download and execute itself
    TEMP_SCRIPT="/tmp/setup_kali_env.sh"
    curl -fsSL https://raw.githubusercontent.com/harshbuddhadev/Misc-Codes/refs/heads/main/Bash/setup_kali_env.sh -o $TEMP_SCRIPT
    chmod +x $TEMP_SCRIPT
    sudo bash $TEMP_SCRIPT
    rm -f $TEMP_SCRIPT
    exit 0
fi

# Step 1: Ensure script is run as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run this script as root (use sudo)."
    exit 1
fi

# Step 2: Update and Upgrade the System
echo "Starting system update and upgrade..."
apt update -y && apt upgrade -y
echo "System update and upgrade completed."

# Step 3: Install avahi-daemon
echo "Installing avahi-daemon..."
apt install avahi-daemon -y
systemctl enable avahi-daemon
systemctl start avahi-daemon
echo "Avahi-daemon installed and started."

# Step 4: Set a New Hostname
read -p "Enter the new hostname: " new_hostname
if [ -n "$new_hostname" ]; then
    echo "Setting the new hostname to: $new_hostname"
    hostnamectl set-hostname "$new_hostname"
    echo "Hostname changed to '$new_hostname'."
else
    echo "Hostname not set. No input provided."
fi

# Step 5: Enable SSH and Configure SSH Keys
echo "Enabling SSH Service..."
systemctl enable ssh.service
systemctl start ssh.service

USER_HOME=$(eval echo "~$SUDO_USER")
SSH_DIR="$USER_HOME/.ssh"
AUTHORIZED_KEYS="$SSH_DIR/authorized_keys"

mkdir -p "$SSH_DIR"
chmod 700 "$SSH_DIR"
chown "$SUDO_USER:$SUDO_USER" "$SSH_DIR"

touch "$AUTHORIZED_KEYS"
chmod 600 "$AUTHORIZED_KEYS"
chown "$SUDO_USER:$SUDO_USER" "$AUTHORIZED_KEYS"

read -p "Public Key: " public_key
if [ -n "$public_key" ]; then
    read -p "Optional comment for key (e.g., 'Harsh's Laptop'): " key_comment
    if [ -n "$key_comment" ]; then
        public_key="$public_key # $key_comment"
    fi
    echo "$public_key" >> "$AUTHORIZED_KEYS"
    echo "Public key added."
else
    echo "No public key provided."
fi

# Step 6: Install Tailscale
echo "Installing Tailscale..."
curl -fsSL https://tailscale.com/install.sh | sh
echo "Tailscale installed."

# Completion message
echo "Script execution completed successfully."
