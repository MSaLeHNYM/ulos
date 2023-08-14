#!/bin/bash

csv_file="../database/users.csv"

echo "Currently connected SSH users on port 1001:"

# Read the list of usernames from the CSV file
user_list=$(cut -d',' -f1 "$csv_file")

# Use 'ss' to list listening ports and 'ps' to list SSH-related processes
connected_users=$(ss -tuln | grep ':1001' && ps -ef | grep sshd | awk '{print $1}' | sort | uniq)

# Count the number of connections for each user and display if user is in the list
for username in $connected_users; do
    if [[ "$username" != "0" && ("$user_list" =~ "$username" || "$username" == "root") ]]; then
        ssh_connections=$(ps -ef | grep "sshd: $username@pts" | wc -l)

        if [[ "$username" == "root" ]]; then
            echo -e "\e[32mUser: $username, Connections: $ssh_connections\e[0m"
        else
            echo "User: $username, Connections: $ssh_connections"
        fi
    fi
done
