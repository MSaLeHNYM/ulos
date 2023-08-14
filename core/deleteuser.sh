#!/bin/bash

csv_file="database/users.csv"
pam_limits_file="/etc/security/limits.conf"

if [ $# -ne 1 ]; then
    echo "Usage: $0 <username>"
    exit 1
fi

username="$1"

# Check if the user exists in the CSV file
if grep -q "^$username," "$csv_file"; then
    # Remove the user entry from the CSV file
    grep -v "^$username," "$csv_file" > temp.csv
    mv temp.csv "$csv_file"
    
    echo "User '$username' deleted from users.csv."

    # Remove PAM limits for the user
    if sudo sed -i "/^$username\s*hard\s*nproc\s*/d" "$pam_limits_file"; then
        echo "PAM limits removed for user '$username'."
    else
        echo "PAM limits for user '$username' not found in $pam_limits_file."
    fi
else
    echo "User '$username' not found in users.csv."
fi
