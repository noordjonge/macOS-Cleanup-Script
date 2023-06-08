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
echo "The author of this script, takes no responsibility for any damage or loss"
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
print_colored_text "35" "Author: Noordjonge"
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

# Function to clear DNS cache
clear_dns_cache() {
	print_colored_text "36" "Clearing DNS cache..."
	sudo dscacheutil -flushcache
	sudo killall -HUP mDNSResponder
	print_colored_text "32" "DNS cache cleared successfully."
	echo ""
}

√

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
	print_colored_text "$CYAN" "Deleting private data..."

	echo "WARNING: By deleting private data, the following information will be permanently deleted and cannot be recovered:"
	echo "- Browsing history"
	echo "- Cookies"
	echo "- Download history"
	echo "- Cache files"
	echo "- Form autofill data"
	echo "- Website data"
	echo ""
	echo "Please note that this action cannot be undone."
	echo ""
	echo "DISCLAIMER: The author of this script does not assume any liability for the deletion of private data. It is your responsibility to ensure that you have a backup of any important data before proceeding."
	echo ""

	read -p "Do you want to proceed and delete private data? (yes/no): " private_data_confirmation

	if [ "$private_data_confirmation" = "yes" ]; then
		echo ""
		print_colored_text "$RED" "Deleting private data..."
		
		# Delete cookies in Safari
		defaults write com.apple.Safari ClearBrowsingHistoryOnQuit -bool true
		rm -rf ~/Library/Cookies/com.apple.Safari.SafeBrowsing.binarycookies
		rm -rf ~/Library/Cookies/Cookies.binarycookies

		# Delete cookies in Firefox (if installed)
		if [ -d "/Applications/Firefox.app" ]; then
			/Applications/Firefox.app/Contents/MacOS/firefox --setDefaultBrowser -ProfileManager
			firefox_profile_path=$(find ~/Library/Application\ Support/Firefox/Profiles -maxdepth 1 -type d -name "*.default")
			rm -rf "$firefox_profile_path"/cookies.sqlite
		fi

		# Delete cookies in Google Chrome (if installed)
		if [ -d "/Applications/Google Chrome.app" ]; then
			/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --delete-profile-data
		fi

		# Delete cookies in Opera (if installed)
		if [ -d "/Applications/Opera.app" ]; then
			/Applications/Opera.app/Contents/MacOS/Opera --delete-private-data
		fi

		# Delete cookies in Microsoft Edge (if installed)
		if [ -d "/Applications/Microsoft Edge.app" ]; then
			/Applications/Microsoft\ Edge.app/Contents/MacOS/Microsoft\ Edge --delete-profile-data
		fi

		# Delete other private data in Safari
		rm -rf ~/Library/Caches/com.apple.Safari
		rm -rf ~/Library/Caches/com.apple.WebKit.Networking
		rm -rf ~/Library/Safari/AutoFill*
		rm -rf ~/Library/Safari/Databases
		rm -rf ~/Library/Safari/LocalStorage

		print_colored_text "$GREEN" "Private data deleted successfully."
		echo ""
	else
		print_colored_text "$YELLOW" "Private data remains unchanged."
		echo ""
	fi
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
while true; do
	print_colored_text "33" "==================== MAIN MENU ===================="
	echo "Please select an option:"
	echo "1. Clean system cache"
	echo "2. Empty trash"
	echo "3. Check disk permissions"
	echo "4. Renew Spotlight index"
	echo "5. Clear DNS cache"
	echo "6. Change DNS server"
	echo "7. Run Internet speedtest"
	echo "8. Delete private data"
	echo "9. Analyze disk space"
	echo "10. Check for outdated software"
	echo "11. Display system information"
	echo "12. Exit"
	echo ""

	read -p "Enter your choice (1-12): " choice
	echo ""

	case $choice in
		1) clean_system_cache ;;
		2) empty_trash ;;
		3) check_disk_permissions ;;
		4) renew_spotlight_index ;;
		5) clear_dns_cache ;;
		6) change_dns_server ;;
		7) run_speedtest ;;
		8) delete_private_data ;;
		9) analyze_disk_space ;;
		10) check_outdated_software ;;
		11) display_system_information ;;
		12) print_colored_text "32" "Exiting..."; exit ;;
		*) print_colored_text "31" "Invalid choice. Please select a valid option." ;;
	esac

	read -p "Press Enter to return to the main menu."
	echo ""
done
