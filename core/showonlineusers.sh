#!/bin/bash

csv_file="database/users.csv"

GREEN="\e[32m"
YELLOW="\e[33m"
PURPLE="\e[35m"
RESET="\e[0m"

echo -e "${PURPLE}Connected Users via SSH on Port 1001:${RESET}"
echo "------------------------------------------"

# Read the list of usernames from the CSV file
user_list=$(cut -d',' -f1 "$csv_file")

# Use 'ss' to list listening ports and 'ps' to list SSH-related processes
connected_users=$(ss -tuln | grep ':1001' && ps -ef | grep sshd | awk '{print $1}' | sort | uniq)

# Count the number of connections for each user and display if user is in the list
for username in $connected_users; do
    if [[ "$username" != "0" && ("$user_list" =~ "$username" || "$username" == "root") ]]; then
        ssh_connections=$(ps -ef | grep "sshd: $username@pts" | wc -l)

        echo -e "${GREEN}Username:${RESET} $username"
        echo -e "${YELLOW}Connections:${RESET} $ssh_connections"
        echo "------------------------------------------"
    fi
done
