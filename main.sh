#!/bin/bash

print_menu() {
    echo "Select an option:"
    echo "1. Update Users"
    echo "2. Add Connection Limits"
    echo "3. Quit"
}

read_option() {
    read -p "Enter your choice: " choice
    case $choice in
        1) ./updateusers.sh ;;
        2) 
            read -p "Enter the username: " username
            read -p "Enter the connection limit: " limit
            ./addlimit.sh "$username" "$limit"
            ;;
        3) echo "Exiting." ; exit 0 ;;
        *) echo "Invalid option. Please select a valid option." ;;
    esac
}

while true; do
    print_menu
    read_option
done
