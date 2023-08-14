#!/bin/bash

print_menu() {
    echo "Select an option:"
    echo "1. Add Users"
    echo "2. Add Connection Limits"
    echo "3. Update Users"
    echo "4. Quit"
}

read_option() {
    read -p "Enter your choice: " choice
    case $choice in
        1) ./adduser.sh ;;
        2) ./addlimit.sh ;;
        3) ./updateusers.sh ;;
        4) echo "Exiting." ; exit 0 ;;
        *) echo "Invalid option. Please select a valid option." ;;
    esac
}

while true; do
    print_menu
    read_option
done
