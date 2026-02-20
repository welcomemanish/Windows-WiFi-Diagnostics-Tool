# 🛜 Windows WiFi Diagnostics Tool

A lightweight, portable Windows WiFi diagnostics collector that gathers comprehensive wireless network information and packages it into a single ZIP file — ready to send to IT support or keep for your own records.

**No installation required. Just double-click and run.**

---

## 📋 What It Does

Runs a full suite of Windows network and WiFi diagnostic commands, saves all output to a timestamped `.txt` report, copies the Windows built-in WLAN HTML report, and compresses everything into a single `.zip` archive.

---

## 📦 What's Collected

| Category | Commands |
|---|---|
| **Basic Connectivity** | `ipconfig /all`, `route print`, ping, traceroute, nslookup |
| **Proxy Settings** | `netsh winhttp show proxy` |
| **MTU Tests** | Fragmentation tests at 1472 and 1500 bytes |
| **WiFi Adapter & Driver** | `netsh wlan show drivers`, `interfaces`, `wirelesscapabilities` |
| **WiFi Configuration** | `autoconfig`, `settings`, `randomization`, `tracing` |
| **Networks & Profiles** | Visible networks with BSSID, saved profiles, filters, blocked networks |
| **Windows WLAN Report** | Full HTML report via `netsh wlan show wlanreport` |

---

## 🚀 How To Use

1. Download or clone this repository
2. Place `Run_WiFi_Diagnostics.bat` and `WiFi_Diagnostics.ps1` in the **same folder**
3. Double-click **`Run_WiFi_Diagnostics.bat`**
4. Accept the UAC prompt when asked (Administrator rights are required for full output)
5. Wait for the tool to finish — it will close automatically after 15 seconds
6. Find your `WiFi_Report_YYYYMMDD_HHMMSS.zip` in the same folder

> **Tip:** Send the `.zip` file to your IT support team or keep it for your own troubleshooting records.

---

## 📁 Output Files

Running the tool produces:

```
WiFi_Report_20250219_143022.zip
├── WiFi_Diagnostics_20250219_143022.txt      ← Full text report of all commands
└── WiFi_WLANReport_20250219_143022.html      ← Windows built-in WLAN HTML report
```

---

## ⚙️ Requirements

| Requirement | Details |
|---|---|
| **OS** | Windows 10 or Windows 11 |
| **PowerShell** | Version 5.1 or later (built into Windows) |
| **Permissions** | Administrator (UAC prompt will appear automatically) |
| **Network adapter** | A WiFi adapter must be present for WLAN commands to return data |

> No third-party software, no installation, no internet connection needed to run the tool.

---

## 🔒 Privacy & Security

- **All data stays on your machine.** Nothing is uploaded or transmitted anywhere.
- The `.bat` launcher uses `-ExecutionPolicy Bypass` for **this script only** — it does not change your system's PowerShell execution policy.
- You can review the full source code of both files before running.
- The tool collects network configuration data only. It does **not** collect passwords, WiFi PSKs, personal files, or browser data.

---

## 🛠️ Understanding the MTU Tests

The tool runs two ping tests with the "Don't Fragment" flag set:

| Test | Payload | Meaning if it **passes** |
|---|---|---|
| `ping -f -l 1472` | 1472 bytes | Standard 1500-byte MTU is intact |
| `ping -f -l 1500` | 1500 bytes | MTU is larger than standard (uncommon) |

If the **1472 test fails**, your effective MTU is below 1500 — common on VPN connections, PPPoE (DSL), or misconfigured networks. This can cause slow or broken connections for certain applications.

---

## 📄 License

This project is licensed under the **BSD 2-Clause License**. See [LICENSE](LICENSE) for details.

---

## 🤝 Contributing

Contributions are welcome! Please read [CONTRIBUTING.md](CONTRIBUTING.md) before submitting a pull request.

---

## 📬 Author

**Manish Sharma**  
If you find this tool useful, feel free to ⭐ star the repository!
