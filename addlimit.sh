#!/bin/bash

# Read the user and connection limit from the command line
user="$1"
limit="$2"

if [ -z "$user" ] || [ -z "$limit" ]; then
    echo "Usage: $0 <username> <connection_limit>"
    exit 1
fi

# Create user-specific PAM limit configuration
limit_conf="/etc/security/limits.d/$user.conf"
echo "$user hard maxlogins $limit" | sudo tee "$limit_conf"

echo "PAM limits added for user $user."

# Check if pam_limits.so is present in the PAM configuration file
pam_limits_line="session required pam_limits.so"
pam_file="/etc/pam.d/sshd"  # Modify to your service-specific PAM file if needed

if ! sudo grep -q "$pam_limits_line" "$pam_file"; then
    echo "$pam_limits_line" | sudo tee -a "$pam_file"
    echo "Added $pam_limits_line to $pam_file."
fi

systemctl restart ssh
