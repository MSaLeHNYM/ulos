#!/bin/bash

chmod +x showonlineusers.sh
chmod +x updateusers.sh
chmod +x adduser.sh
chmod +x addlimit.sh

GREEN="\e[32m"
YELLOW="\e[33m"
RESET="\e[0m"

echo "Welcome to the ${YELLOW}User Management Script${RESET}"
echo "Select an option:"
echo "1. Show Online Users"
echo "2. Update Users"
echo "3. Add User"
echo "4. Add User Limits"
echo "5. Exit"

read -p "Enter your choice: " choice

case "$choice" in
    1)
        echo -e "${GREEN}Fetching online users...${RESET}"
        sleep 1
        ./showonlineusers.sh
        ;;
    2)
        echo -e "${GREEN}Updating users...${RESET}"
        sleep 1
        ./updateusers.sh
        ;;
    3)
        echo -e "${GREEN}Adding a new user...${RESET}"
        sleep 1
        ./adduser.sh
        ;;
    4)
        read -p "Enter username: " username
        read -p "Enter connection limit: " connection_limit
        echo -e "${GREEN}Adding limits for user...${RESET}"
        sleep 1
        ./addlimit.sh "$username" "$connection_limit"
        ;;
    5)
        echo -e "${GREEN}Exiting...${RESET}"
        sleep 1
        exit
        ;;
    *)
        echo -e "${YELLOW}Invalid choice${RESET}"
        ;;
esac
