#!/bin/bash

chmod +x showonlineusers.sh
chmod +x updateusers.sh
chmod +x adduser.sh
chmod +x addlimit.sh
chmod +x showallusers.sh
chmod +x deleteuser.sh

GREEN="\e[32m"
YELLOW="\e[33m"
RESET="\e[0m"

echo -e "Welcome to the ${YELLOW}User Management Script${RESET}"
while true; do
    echo "Select an option:"
    echo -e "1. ${GREEN}Show Online Users${RESET}"
    echo -e "2. ${GREEN}Update Users${RESET}"
    echo -e "3. ${GREEN}Add User${RESET}"
    echo -e "4. ${GREEN}Add User Limits${RESET}"
    echo -e "5. ${GREEN}Show All Users${RESET}"
    echo -e "6. ${GREEN}Delete User${RESET}"
    echo -e "7. ${GREEN}Exit${RESET}"

    read -p "Enter your choice: " choice

    case "$choice" in
        1)
            echo -e "${GREEN}Fetching online users...${RESET}"
            sleep 1
            ./showonlineusers.sh
            read -n 1 -s -r -p "Press any key to return to the main menu..."
            echo
            ;;
        2)
            echo -e "${GREEN}Updating users...${RESET}"
            sleep 1
            ./updateusers.sh
            read -n 1 -s -r -p "Press any key to return to the main menu..."
            echo
            ;;
        3)
            echo -e "${GREEN}Adding a new user...${RESET}"
            sleep 1
            ./adduser.sh
            read -n 1 -s -r -p "Press any key to return to the main menu..."
            echo
            ;;
        4)
            read -p "Enter username: " username
            read -p "Enter connection limit: " connection_limit
            echo -e "${GREEN}Adding limits for user...${RESET}"
            sleep 1
            ./addlimit.sh "$username" "$connection_limit"
            read -n 1 -s -r -p "Press any key to return to the main menu..."
            echo
            ;;
        5)
            echo -e "${GREEN}Displaying all users...${RESET}"
            sleep 1
            ./showallusers.sh
            read -n 1 -s -r -p "Press any key to return to the main menu..."
            echo
            ;;
        6)
            read -p "Enter username to delete: " delete_username
            echo -e "${GREEN}Deleting user...${RESET}"
            sleep 1
            ./deleteuser.sh "$delete_username"
            read -n 1 -s -r -p "Press any key to return to the main menu..."
            echo
            ;;
        7)
            echo -e "${GREEN}Exiting...${RESET}"
            sleep 1
            exit
            ;;
        *)
            echo -e "${YELLOW}Invalid choice${RESET}"
            ;;
    esac
done
