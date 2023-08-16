#!/bin/bash

csv_file="database/users.csv"

GREEN="\e[32m"
YELLOW="\e[33m"
RED="\e[91m"
RESET="\e[0m"

if [ ! -f "$csv_file" ]; then
    echo -e "${RED}CSV file not found: $csv_file${RESET}"
    exit 1
fi

total_users_processed=0
total_updated_limits=0
total_added_users=0

while IFS=',' read -r username password limit; do
    # Check if the user already exists
    if id "$username" &>/dev/null; then
        echo -e "User ${GREEN}$username${RESET} already exists. Updating connection limit."

        # Remove the existing user limit configuration from limits.conf
        sudo sed -i "/^$username /d" /etc/security/limits.conf

        # Add the updated limit configuration for the user
        echo "$username hard maxlogins $limit" | sudo tee -a /etc/security/limits.conf

        echo -e "Connection limit updated for user ${GREEN}$username${RESET}."
        ((total_updated_limits++))
    else
        # Add the user with the specified shell
        sudo useradd --shell /bin/false "$username"

        # Set the password for the new user
        echo "$username:$password" | sudo chpasswd

        echo -e "User ${YELLOW}$username${RESET} added with /bin/false shell and password set."

        # Add the limit configuration for the new user
        echo "$username hard maxlogins $limit" | sudo tee -a /etc/security/limits.conf

        echo -e "PAM limits added for user ${YELLOW}$username${RESET}."
        ((total_added_users++))
    fi

    ((total_users_processed++))
done < "$csv_file"

systemctl restart ssh
echo -e "${GREEN}All users processed.${RESET}"
echo "Summary:"
echo "Total users processed: $total_users_processed"
echo "Total connection limits updated: $total_updated_limits"
echo "Total users added: $total_added_users"
