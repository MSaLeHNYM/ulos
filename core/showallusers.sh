#!/bin/bash

csv_file="database/users.csv"

GREEN="\e[32m"
YELLOW="\e[33m"
CYAN="\e[36m"
RESET="\e[0m"

total_users=$(wc -l < "$csv_file")

echo -e "${CYAN}All Users with Passwords and Connection Limits:${RESET}"
echo -e "${CYAN}Total Users:${RESET} $total_users"
echo "----------------------------------------------"

while IFS=',' read -r username userpass userlimit; do
    echo -e "${CYAN}$username${RESET} , ${YELLOW}$userpass${RESET} , ${GREEN}$userlimit${RESET}"
done < "$csv_file"
