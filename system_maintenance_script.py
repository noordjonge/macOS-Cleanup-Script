import os
import subprocess

# Function to print colored text
def print_colored_text(color, text):
    print(f"\033[1m\033[{color}m{text}\033[0m")

# Disclaimer and Liability Notice
def print_disclaimer():
    print_colored_text("35", "=================================================")
    print_colored_text("35", "                   DISCLAIMER                    ")
    print_colored_text("35", "=================================================")
    print("")
    print("This script is provided as-is, without any warranty or guarantee.")
    print("The author of this script takes no responsibility for any damage or loss")
    print("caused by the use or misuse of this script.")
    print("")
    print("The script performs various system operations that can modify your system.")
    print("It is recommended to review the script and understand its actions before running it.")
    print("Make sure you have a backup of your important data before proceeding.")
    print("")
    print("By using this script, you acknowledge that you are using it at your own risk.")
    print("The author cannot be held liable for any consequences or damages arising from the use of this script.")
    print("")
    print_colored_text("35", "If you agree to these terms and conditions, enter 'yes' to continue executing the script.")
    print("Entering any other value will terminate the script.")
    print("")
    print_colored_text("35", "Beta Build Version: 0.5")
    print_colored_text("35", "Author: Noordjonge")
    print("")
    print_colored_text("35", "=================================================")
    print("")

def get_user_confirmation():
    confirmation = input("Do you agree to the terms and conditions? (yes/no): ").lower()
    return confirmation == "yes"

# Function to clean system cache
def clean_system_cache():
    print_colored_text("36", "Cleaning system cache...")
    os.system("rm -rf /Library/Caches/*")
    os.system("rm -rf ~/Library/Caches/*")
    print_colored_text("32", "System cache cleaned successfully.")
    print("")

# Function to empty trash
def empty_trash():
    print_colored_text("36", "Emptying trash...")
    os.system("rm -rf ~/.Trash/*")
    os.system("rm -rf /Volumes/*/.Trashes")
    print_colored_text("32", "Trash emptied successfully.")
    print("")

# Function to run disk permissions check and repair
def check_disk_permissions():
    print_colored_text("36", "Checking disk permissions...")
    subprocess.run(["diskutil", "verifyPermissions", "/"])
    print_colored_text("32", "Disk permissions check completed.")
    print("")

# Function to renew Spotlight index
def renew_spotlight_index():
    print_colored_text("36", "Renewing Spotlight index...")
    os.system("mdutil -E /")
    print_colored_text("32", "Spotlight index renewed successfully.")
    print("")

# Function to clear DNS cache
def clear_dns_cache():
    print_colored_text("36", "Clearing DNS cache...")
    os.system("sudo dscacheutil -flushcache")
    os.system("sudo killall -HUP mDNSResponder")
    print_colored_text("32", "DNS cache cleared successfully.")
    print("")

# Function to change DNS server
def change_dns_server():
    print_colored_text("36", "Changing DNS server...")
    dns_server_primary = input("Enter primary DNS server address: ")
    dns_server_secondary = input("Enter secondary DNS server address: ")
    
    os.system(f"networksetup -setdnsservers Wi-Fi {dns_server_primary} {dns_server_secondary}")
    print_colored_text("32", f"DNS server changed to {dns_server_primary} and {dns_server_secondary}.")
    print("")

# Function to run Internet speedtest
def run_speedtest():
    print_colored_text("36", "Running Internet speedtest...")

    if subprocess.run(["command", "-v", "speedtest-cli"]).returncode != 0:
        install_confirmation = input("speedtest-cli is not installed. Do you want to install it? (yes/no): ")

        if install_confirmation.lower() == "yes":
            print_colored_text("36", "Installing speedtest-cli...")
            subprocess.run(["pip", "install", "speedtest-cli"])
            print_colored_text("32", "speedtest-cli installed successfully.")
        else:
            print_colored_text("31", "speedtest-cli is required to run the speedtest. Exiting...")
            exit(1)

    subprocess.run(["speedtest-cli", "--simple"])
    print("")

# Function to delete private data
def delete_private_data():
    print_colored_text("36", "Deleting private data...")
    # Add logic to delete private data (cookies, browsing history, etc.) for different browsers
    # This will depend on the browsers installed on the system
    # ...
    print_colored_text("32", "Private data deleted successfully.")
    print("")

# Function to perform disk space analysis
def analyze_disk_space():
    print_colored_text("36", "Analyzing disk space...")
    os.system("df -h")
    print("")

# Function to check for outdated software
def check_outdated_software():
    print_colored_text("36", "Checking for outdated software...")
    subprocess.run(["softwareupdate", "-l"])
    print("")

# Function to display system information
def display_system_information():
    print_colored_text("36", "Displaying system information...")
    subprocess.run(["system_profiler", "SPSoftwareDataType", "SPHardwareDataType"])
    print("")

# Main menu
def main_menu():
    while True:
        print_colored_text("33", "==================== MAIN MENU ====================")
        print("Please select an option:")
        print("1. Clean system cache")
        print("2. Empty trash")
        print("3. Check disk permissions")
        print("4. Renew Spotlight index")
        print("5. Clear DNS cache")
        print("6. Change DNS server")
        print("7. Run Internet speedtest")
        print("8. Delete private data")
        print("9. Analyze disk space")
        print("10. Check for outdated software")
        print("11. Display system information")
        print("12. Exit")
        print("")

        choice = input("Enter your choice (1-12): ")
        print("")

        if choice == "1":
            clean_system_cache()
        elif choice == "2":
            empty_trash()
        elif choice == "3":
            check_disk_permissions()
        elif choice == "4":
            renew_spotlight_index()
        elif choice == "5":
            clear_dns_cache()
        elif choice == "6":
            change_dns_server()
        elif choice == "7":
            run_speedtest()
        elif choice == "8":
            delete_private_data()
        elif choice == "9":
            analyze_disk_space()
        elif choice == "10":
            check_outdated_software()
        elif choice == "11":
            display_system_information()
        elif choice == "12":
            print_colored_text("32", "Exiting...")
            break
        else:
            print_colored_text("31", "Invalid choice. Please select a valid option.")

        input("Press Enter to return to the main menu.\n")
        print("")

# Main program
if __name__ == "__main__":
    print_disclaimer()
    
    if get_user_confirmation():
        main_menu()
    else:
        print_colored_text("31", "Script execution aborted. Exiting...")
