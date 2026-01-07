# Windows WiFi Diagnostics Tool

A simple, standalone PowerShell-based tool for Windows that runs essential network and WiFi diagnostic commands (like `netsh wlan`, `ipconfig`, `ping`, `tracert`, etc.) and saves the output to a timestamped TXT file. Ideal for IT support, troubleshooting wireless issues, and quick system checks.

This lightweight, open-source script automates collecting comprehensive WiFi and network info, displaying results in the console while logging to a file for easy sharing and analysis. Perfect for IT professionals, network engineers, or anyone debugging connectivity, MTU issues, proxies, or network health.

## Features
- **Automated Diagnostics**: Runs a suite of essential commands to gather WiFi drivers, interfaces, networks, profiles, and more.
- **Additional Network Checks**: Includes IP configuration, routing tables, ping tests (including MTU fragmentation checks), traceroute, DNS lookup, and proxy info.
- **Output Logging**: Saves all results to a file like `Windows_WiFi_Diagnostics_YYYYMMDD_HHMMSS.txt` in the same directory as the script/EXE.
- **User-Friendly Console**: Color-coded output with headers for easy reading; auto-closes after 10 seconds.
- **Timestamped Reports**: Each run generates a unique file with system details (date, user, computer name).
- **EXE Ready**: Easily standalone executable for non-technical users.
- **No Installation Required**: Runs as a script or EXE with admin privileges.

## Requirements
- Windows 10 or later (with PowerShell 5.1+).
- Admin privileges for full access to network commands.
- For EXE conversion: PS2EXE module (free from PowerShell Gallery).

## Usage
1. Double-click `WindowsWiFiDiagnostics.exe` (run as admin if prompted).
1. The output file (TXT) and copied WLAN report (HTML) will be created in the same directory.
**Note**: Admin rights are required for most commands. The console auto-closes after 10 seconds, but reports are always saved.

## List of Commands
The tool executes and logs:
- `get-date`
- `ipconfig /all`
- `route print`
- `ping 8.8.8.8`
- `tracert -d -w 400 8.8.8.8`
- `nslookup google.com`
- `netsh winhttp show proxy`
- `ping 8.8.8.8 -f -l 1472`
- `ping 8.8.8.8 -f -l 1500`
- `netsh wlan show drivers`
- `netsh wlan show interfaces`
- `netsh wlan show networks mode=bssid`
- `netsh wlan show wirelesscapabilities`
- `netsh wlan show autoconfig`
- `netsh wlan show filters`
- `netsh wlan show randomization`
- `netsh wlan show tracing`
- `netsh wlan show networks`
- `netsh wlan show profiles`
- `netsh wlan show settings`
- `netsh wlan show hostednetwork`
- `netsh wlan show blockednetworks`
- `netsh wlan show all`
- `netsh wlan show wlanreport`

## Contributing
Feel free to submit issues, or feedback!

## Contact
- Author: Manish Sharma
- GitHub: [@welcomemanish](https://github.com/welcomemanish)

---
*Last updated: January 07, 2026*
