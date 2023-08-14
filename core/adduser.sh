#!/bin/bash

csv_file="database/users.csv"
pam_limit_line="session required pam_limits.so"

read -p "Enter username: " username
read -s -p "Enter password: " password
echo
read -p "Enter connection limit: " connection_limit

# Add the user
sudo adduser "$username" --shell /bin/false --disabled-password --gecos ""

# Set the password
echo "$username:$password" | sudo chpasswd

# Add PAM limit to the user's PAM config file
pam_config_file="/etc/security/limits.conf"
if ! grep -q "$pam_limit_line" "$pam_config_file"; then
    echo "$pam_limit_line" | sudo tee -a "$pam_config_file"
fi

# Update the user's limit in PAM config
sudo sed -i "/^$username .*$/d" "$pam_config_file"
echo "$username hard maxlogins $connection_limit" | sudo tee -a "$pam_config_file"

# Update users.csv
echo "$username,$password,$connection_limit" >> "$csv_file"

echo "User $username added successfully with password and limit."
