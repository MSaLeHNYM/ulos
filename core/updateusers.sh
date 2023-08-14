#!/bin/bash

csv_file="../database/users.csv"

if [ ! -f "$csv_file" ]; then
    echo "CSV file not found: $csv_file"
    exit 1
fi

pam_limits_line="session required pam_limits.so"
pam_file="/etc/pam.d/sshd"  # Modify to your service-specific PAM file if needed

if ! sudo grep -q "$pam_limits_line" "$pam_file"; then
    echo "$pam_limits_line" | sudo tee -a "$pam_file"
    echo "Added $pam_limits_line to $pam_file."
fi

while IFS=',' read -r username password limit; do
    # Check if the user already exists
    if id "$username" &>/dev/null; then
        echo "User $username already exists. Updating connection limit."

        # Update user-specific PAM limit configuration
        limit_conf="/etc/security/limits.d/$username.conf"
        echo "$username hard maxlogins $limit" | sudo tee "$limit_conf"

        echo "Connection limit updated for user $username."
    else
        # Add the user with the specified shell
        sudo useradd --shell /bin/false "$username"

        # Set the password for the new user
        echo "$username:$password" | sudo chpasswd

        echo "User $username added with /bin/false shell and password set."

        # Create user-specific PAM limit configuration
        limit_conf="/etc/security/limits.d/$username.conf"
        echo "$username hard maxlogins $limit" | sudo tee "$limit_conf"

        echo "PAM limits added for user $username."
    fi
done < "$csv_file"

systemctl restart ssh
echo "All users processed."
