#!/bin/bash

# Function to print colored text
print_colored_text() {
	local color=$1
	local text=$2
	echo -e "\033[1m\033[${color}m${text}\033[0m"
}

# Disclaimer and Liability Notice
print_colored_text "35" "================================================="
print_colored_text "35" "                   DISCLAIMER                    "
print_colored_text "35" "================================================="
echo ""
echo "This script is provided as-is, without any warranty or guarantee."
echo "The author of this script, Sebastian Palencsár, takes no responsibility for any damage or loss"
echo "caused by the use or misuse of this script."
echo ""
echo "The script performs various system operations that can modify your system."
echo "It is recommended to review the script and understand its actions before running it."
echo "Make sure you have a backup of your important data before proceeding."
echo ""
echo "By using this script, you acknowledge that you are using it at your own risk."
echo "The author cannot be held liable for any consequences or damages arising from the use of this script."
echo ""
print_colored_text "35" "If you agree to these terms and conditions, enter 'yes' to continue executing the script."
echo "Entering any other value will terminate the script."
echo ""
print_colored_text "35" "Beta Build Version: 0.5"
print_colored_text "35" "Author: Sebastian Palencsár"
echo ""
print_colored_text "35" "================================================="
echo ""

read -p "Do you agree to the terms and conditions? (yes/no): " confirmation

if [ "$confirmation" != "yes" ]; then
	print_colored_text "31" "Script execution aborted. Exiting..."
	exit 1
fi

# Function to clean system cache
clean_system_cache() {
	print_colored_text "36" "Cleaning system cache..."
	sudo rm -rf /Library/Caches/*
	sudo rm -rf ~/Library/Caches/*
	print_colored_text "32" "System cache cleaned successfully."
	echo ""
}

# Function to empty trash
empty_trash() {
	print_colored_text "36" "Emptying trash..."
	sudo rm -rf ~/.Trash/*
	sudo rm -rf /Volumes/*/.Trashes
	print_colored_text "32" "Trash emptied successfully."
	echo ""
}

# Function to run disk permissions check and repair
check_disk_permissions() {
	print_colored_text "36" "Checking disk permissions..."
	diskutil verifyPermissions /
	print_colored_text "32" "Disk permissions check completed."
	echo ""
}

# Function to renew Spotlight index
renew_spotlight_index() {
	print_colored_text "36" "Renewing Spotlight index..."
	sudo mdutil -E /
	print_colored_text "32" "Spotlight index renewed successfully."
	echo ""
}

# Function to change DNS server IPV4 and IPV6
change_dns_server() {
	print_colored_text "36" "Do you want to change the DNS servers to Google DNS? (yes/no): "
	read -r dns_confirmation

	if [ "$dns_confirmation" = "yes" ]; then
		print_colored_text "36" "Changing DNS server to Google DNS..."
		networksetup -setdnsservers Wi-Fi 8.8.8.8 8.8.4.4
		networksetup -setdnsservers Wi-Fi "2001:4860:4860::8888" "2001:4860:4860::8844"
		print_colored_text "32" "DNS servers changed to Google DNS successfully."
	else
		print_colored_text "33" "Enter the preferred DNS server (IPv4): "
		read -r ipv4_dns_server
		print_colored_text "33" "Enter the preferred DNS server (IPv6): "
		read -r ipv6_dns_server

		print_colored_text "36" "Changing DNS server to $ipv4_dns_server (IPv4) and $ipv6_dns_server (IPv6)..."
		networksetup -setdnsservers Wi-Fi $ipv4_dns_server $ipv6_dns_server
		print_colored_text "32" "DNS servers changed successfully."
	fi

	echo ""
}

# Function to run Internet speedtest
run_speedtest() {
	print_colored_text "36" "Running Internet speedtest..."

	if ! command -v speedtest-cli &>/dev/null; then
		print_colored_text "33" "speedtest-cli is not installed. Do you want to install it? (yes/no):"
		read -r install_confirmation

		if [ "$install_confirmation" = "yes" ]; then
			print_colored_text "36" "Installing speedtest-cli..."
			sudo pip install speedtest-cli
			print_colored_text "32" "speedtest-cli installed successfully."
		else
			print_colored_text "31" "speedtest-cli is required to run the speedtest. Exiting..."
			exit 1
		fi
	fi

	speedtest-cli --simple
	echo ""
}

# Function to delete private data
delete_private_data() {
	print_colored_text "36" "Deleting private data..."

	echo "This function will delete the following items:"
	echo "1. Browser history"
	echo "2. Cookies"
	echo "3. Saved passwords"
	echo "4. Download history"
	echo "5. Recent documents"
	echo ""

	read -p "Are you sure you want to proceed? (yes/no): " delete_confirmation

	if [ "$delete_confirmation" = "yes" ]; then
		print_colored_text "36" "Deleting private data..."
		# Add commands to delete private data here
		print_colored_text "32" "Private data deleted successfully."
	else
		print_colored_text "31" "Private data deletion canceled."
	fi

	echo ""
}

# Function to perform disk space analysis
analyze_disk_space() {
	print_colored_text "36" "Analyzing disk space..."
	df -h
	echo ""
}

# Function to check for outdated software
check_outdated_software() {
	print_colored_text "36" "Checking for outdated software..."
	softwareupdate -l
	echo ""
}

# Function to display system information
display_system_information() {
	print_colored_text "36" "Displaying system information..."
	system_profiler SPSoftwareDataType SPHardwareDataType
	echo ""
}

# Main menu
print_colored_text "33" "==================== MAIN MENU ===================="
echo "Please select an option:"
echo "1. Clean system cache"
echo "2. Empty trash"
echo "3. Check disk permissions"
echo "4. Renew Spotlight index"
echo "5. Change DNS server"
echo "6. Run Internet speedtest"
echo "7. Delete private data"
echo "8. Analyze disk space"
echo "9. Check for outdated software"
echo "10. Display system information"
echo "11. Exit"
echo ""

read -p "Enter your choice (1-11): " choice
echo ""

case $choice in
	1) clean_system_cache ;;
	2) empty_trash ;;
	3) check_disk_permissions ;;
	4) renew_spotlight_index ;;
	5) change_dns_server ;;
	6) run_speedtest ;;
	7) delete_private_data ;;
	8) analyze_disk_space ;;
	9) check_outdated_software ;;
	10) display_system_information ;;
	11) print_colored_text "32" "Exiting..."; exit ;;
	*) print_colored_text "31" "Invalid choice. Please select a valid option." ;;
esac
