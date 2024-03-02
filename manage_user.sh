#!/bin/bash

# User Management Script

# Function to display menu
display_menu() {
    echo "User Management Menu"
    echo "1. Create a new user"
    echo "2. Modify an existing user"
    echo "3. Delete a user"
    echo "4. Check user information"
    echo "5. Exit"
}

# Function to create a new user
create_user() {
    read -p "Enter username: " username
    read -p "Enter full name: " full_name
    read -s -p "Enter password: " password
    echo ""
    sudo useradd -m -c "$full_name" "$username"  # Create user with home directory and comment
    echo "$username:$password" | sudo chpasswd  # Set password for the user
    echo "User $username has been created."
}

# Function to modify an existing user
modify_user() {
    read -p "Enter username to modify: " username
    read -p "Enter new full name (leave blank to keep existing): " new_full_name
    if [ -n "$new_full_name" ]; then
        sudo usermod -c "$new_full_name" "$username"  # Modify user's full name
    fi
    echo "User $username has been modified."
}

# Function to delete a user
delete_user() {
    read -p "Enter username to delete: " username
    sudo userdel -r "$username"  # Remove user and home directory
    echo "User $username has been deleted."
}

# Function to check user information
check_user_info() {
    if ! command -v finger &> /dev/null; then
        read -p "The 'finger' command is not available on your system. Do you want to install it? (y/n): " install_finger
        if [ "$install_finger" == "y" ]; then
            sudo apt-get install finger  # Install finger command (for Debian-based systems)
        else
            echo "Cannot display user information without the 'finger' command."
            return
        fi
    fi
    read -p "Enter username to check: " username
    echo "User information for $username:"
    sudo finger "$username"  # Display user information using finger command
}

# Main loop
while true; do
    display_menu
    read -p "Enter your choice: " choice
    case $choice in
        1) create_user ;;
        2) modify_user ;;
        3) delete_user ;;
        4) check_user_info ;;
        5) echo "Exiting."; break ;;
        *) echo "Invalid choice. Please enter a number between 1 and 5." ;;
    esac
    echo ""
done
