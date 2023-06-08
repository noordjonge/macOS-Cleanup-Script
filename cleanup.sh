#!/bin/bash

# Disclaimer and confirmation prompt
show_disclaimer_and_confirmation() {
    echo "========== DISCLAIMER =========="
    echo "IMPORTANT: Please read the following disclaimer carefully before executing this script."
    echo "This script performs system-related actions that may have an impact on your macOS system."
    echo "It can result in data loss or other unexpected issues."
    echo "Make sure you have a current backup of your important data before using this script."
    echo "The author of this script accepts no liability for any damages or losses that may arise from using this script."
    echo ""
    echo "Please note the following:"
    echo "1. You are using this script at your own risk. You are solely responsible for the consequences of executing this script."
    echo "2. Make sure you understand the functions of this script and that it meets your individual requirements."
    echo "3. Only execute this script on a macOS system for which you have administrative rights."
    echo "4. Take a full backup of your data before running this script."
    echo ""
    echo "By confirming, you agree that you have read the above notices and assume full responsibility for executing this script."
    echo ""
    read -p "Do you agree? (y/n): " confirmation
    if [[ $confirmation != "y" ]]; then
        echo "Script canceled."
        exit 0
    fi
}

# Clean system caches
clean_system_cache() {
    echo "Cleaning system caches..."
    sudo rm -rf /Library/Caches/*
    echo "System caches cleaned."
}

# Clean user caches
clean_user_cache() {
    echo "Cleaning user caches..."
    rm -rf ~/Library/Caches/*
    echo "User caches cleaned."
}

# Clean system logs
clean_system_logs() {
    echo "Cleaning system logs..."
    sudo rm -rf /private/var/log/*
    echo "System logs cleaned."
}

# Clean language files
clean_language_files() {
    echo "Cleaning language files..."
    sudo rm -rf /Library/LanguagePacks/*
    echo "Language files cleaned."
}

# Clean trash
clean_trash() {
    echo "Emptying trash..."
    rm -rf ~/.Trash/*
    sudo rm -rf /Volumes/*/.Trashes/*
    echo "Trash emptied."
}

# Resize Time Machine snapshots
resize_time_machine_snapshots() {
    echo "Resizing Time Machine snapshots..."
    sudo tmutil thinlocalsnapshots / 9999999999999999
    echo "Time Machine snapshots resized."
}

# Check and repair disk permissions
check_and_repair_disk_permissions() {
    echo "Checking and repairing disk permissions..."
    sudo diskutil repairPermissions /
    echo "Disk permissions checked and repaired."
}

# Check disk usage
check_disk_usage() {
    echo "Checking disk usage..."
    df -h
    echo "Disk usage checked."
}

# Update system software
update_system_software() {
    echo "Checking for system software updates..."
    sudo softwareupdate -ia
    echo "System software updated."
}

# Remove unused applications
remove_unused_applications() {
    echo "Searching for unused applications..."
    # List of applications to be removed
    apps_to_remove=("UnneededApp1.app" "UnneededApp2.app")
    
    for app in "${apps_to_remove[@]}"; do
        if [ -d "/Applications/$app" ]; then
            read -p "Do you want to remove $app? (y/n): " confirmation
            if [[ $confirmation == "y" ]]; then
                echo "Removing $app..."
                sudo rm -rf "/Applications/$app"
                echo "$app removed."
            fi
        fi
    done
}

# Check network connection
check_network_connection() {
    echo "Checking network connection..."
    ping -c 5 google.com
    echo "Network connection checked."
}

# Main function
main() {
    clean_system_cache
    clean_user_cache
    clean_system_logs
    clean_language_files
    clean_trash
    resize_time_machine_snapshots
    check_and_repair_disk_permissions
    check_disk_usage
    update_system_software
    remove_unused_applications
    check_network_connection
}

# Show disclaimer and prompt for confirmation
show_disclaimer_and_confirmation

# Call the main function
main
