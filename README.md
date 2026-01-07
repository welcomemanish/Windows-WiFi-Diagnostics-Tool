# Windows-WiFi-Diagnostics-Tool
A simple, standalone PowerShell-based tool for Windows that runs essential network and WiFi diagnostic commands (like netsh wlan, ipconfig, ping, tracert etc.) and saves the output to a timestamped TXT file. Ideal for IT support, troubleshooting wireless issues, and quick system checks.

Windows WiFi Diagnostics Tool
A lightweight, open-source PowerShell script designed to collect comprehensive WiFi and network diagnostic information on Windows systems. This tool automates running key commands like netsh wlan, ipconfig, ping, tracert, and more, displaying results in the console while saving them to a timestamped TXT file for easy sharing and analysis.

Perfect for IT professionals, network engineers, or anyone troubleshooting wireless connectivity issues, MTU problems, proxy settings, or general network health.

Features
**Automated Diagnostics**: Runs a suite of essential commands to gather WiFi drivers, interfaces, networks, profiles, and more.
**Additional Network Checks**: Includes IP configuration, routing tables, ping tests (including MTU fragmentation checks), traceroute, DNS lookup, and proxy info.
**Output Logging**: Saves all results to a file like Windows_WiFi_Diagnostics_YYYYMMDD_HHMMSS.txt in the same directory as the script/EXE.
**User-Friendly Console**: Color-coded output with headers for easy reading; auto-closes after 5 seconds.
**Timestamped Reports**: Each run generates a unique file with system details (date, user, computer name).
**EXE Ready**: Standalone executable EXE for non-technical users.
**No Installation Required**: Runs EXE with admin privileges.

**Usage**
--Double-click Windows WiFi Diagnostics Tool.exe (run as admin if prompted).
--Output file will be created under same directory.
--The console auto-closes after 5 seconds, but the report is always saved.
**Note**: Admin rights are required for most network commands.

**List of Commands**
--get-date
--ipconfig /all
--route print
--ping 8.8.8.8
--tracert -d -w 400 8.8.8.8
--nslookup google.com
--netsh winhttp show proxy
--ping 8.8.8.8 -f -l 1472
--ping 8.8.8.8 -f -l 1500
--"netsh wlan show drivers
--netsh wlan show interfaces
--netsh wlan show networks mode=bssid
--netsh wlan show wirelesscapabilities
--netsh wlan show autoconfig
--netsh wlan show filters
--netsh wlan show randomization
--netsh wlan show tracing
--netsh wlan show networks
--netsh wlan show profiles
--netsh wlan show settings
--netsh wlan show hostednetwork
--netsh wlan show blockednetworks
--netsh wlan show all
--netsh wlan show wlanreport

Contributing
Feel free to submit issues or feedback! Suggestions for macOS/Linux versions or additional commands are welcome.

Contact
Author: Manish Sharma
GitHub: [@welcomemanish](https://github.com/welcomemanish)

--------
Last updated: January 07, 2026
