# System Maintenance Script

## Author
Sebastian Palencsar

Version: 0.3 Beta

## Overview

This Python script is designed to perform various system maintenance tasks on macOS version 10.0 or higher. It includes functionalities such as cleaning system cache, emptying trash, checking disk permissions, renewing the Spotlight index, clearing DNS cache, changing DNS servers, running an Internet speed test, deleting private data, analyzing disk space, checking for outdated software, and displaying system information.

## Disclaimer

Before using this script, please read the disclaimer and liability notice in the script itself. By using the script, you acknowledge that you are using it at your own risk, and the author cannot be held liable for any consequences or damages arising from its use.

## Prerequisites

- macOS version 10.0 or higher
- Python installed on your system (if not installed, follow the installation instructions below)

## Installation of Python on macOS

To run this script, Python must be installed on your macOS system. Follow these steps to install Python:

```bash
1. Open a terminal window.

2. Check if Python is already installed by running the following command:
   ```bash
   python3 --version
   ```
   If Python is not installed, you will see a message indicating that it is not found.

3. Install Homebrew (if not already installed):
   ```bash
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```

4. Install Python 3 using Homebrew:
   ```bash
   brew install python
   ```

5. After installation, verify that Python is installed by running:
   ```bash
   python3 --version
   ```
   You should see the Python version number.
```

## Running the Script

1. Clone or download this repository to your local machine.

2. Open a terminal and navigate to the directory containing the script.

3. Run the script using the following command:
   ```bash
   python3 system_maintenance_script.py
   ```

4. Follow the on-screen instructions to choose the desired maintenance tasks from the main menu.

## Contributing

If you encounter issues, have suggestions, or want to contribute to the script's development, please feel free to open an issue or submit a pull request on the 

[GitHub repository](https://github.com/noordjonge/macOS-Cleanup-Script).

## License

This script is licensed under the [MIT License](LICENSE).
