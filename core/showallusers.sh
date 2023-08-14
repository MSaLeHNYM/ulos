#!/bin/bash

csv_file="database/users.csv"

GREEN="\e[32m"
YELLOW="\e[33m"
CYAN="\e[36m"
RESET="\e[0m"

echo -e "${CYAN}All Users with Passwords and Connection Limits:${RESET}"
echo "----------------------------------------------"

while IFS=',' read -r username userpass userlimit; do
    echo -e "${GREEN}Username:${RESET} $username"
    echo -e "${YELLOW}Password:${RESET} $userpass"
    echo -e "${GREEN}Limit:${RESET} $userlimit"
    echo "----------------------------------------------"
done < "$csv_file"
