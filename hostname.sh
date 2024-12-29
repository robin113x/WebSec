#!/bin/bash

# New hostname and username
NEW_HOSTNAME="robin"
NEW_USERNAME="hood"

# Current username
CURRENT_USERNAME=$(whoami)

# Ensure script is run with sudo
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root. Use 'sudo'."
    exit 1
fi

# Change hostname
echo $NEW_HOSTNAME > /etc/hostname
sed -i "s/127\.0\.1\.1.*/127.0.1.1\t$NEW_HOSTNAME/" /etc/hosts
hostnamectl set-hostname $NEW_HOSTNAME
echo "Hostname changed to $NEW_HOSTNAME."

# Change username
if [ "$CURRENT_USERNAME" != "$NEW_USERNAME" ]; then
    usermod -l $NEW_USERNAME -m -d /home/$NEW_USERNAME $CURRENT_USERNAME
    groupmod -n $NEW_USERNAME $CURRENT_USERNAME
    echo "Username changed from $CURRENT_USERNAME to $NEW_USERNAME."

    # Update references to old username in sudoers
    if grep -q $CURRENT_USERNAME /etc/sudoers; then
        sed -i "s/$CURRENT_USERNAME/$NEW_USERNAME/g" /etc/sudoers
        echo "Updated sudoers file with the new username."
    fi

    # Notify about logout/re-login
    echo "Log out and log in with the new username ($NEW_USERNAME) to ensure changes are fully applied."
else
    echo "Username is already $NEW_USERNAME."
fi

# Optional: Prompt to reboot
read -p "Reboot now to apply all changes? (y/n): " REBOOT_CHOICE
if [[ $REBOOT_CHOICE == "y" || $REBOOT_CHOICE == "Y" ]]; then
    reboot
fi

