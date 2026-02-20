# ============================================================
# Windows WiFi Diagnostics Tool
# by Manish Sharma
# ============================================================

# ---- Auto-relaunch as Administrator if not elevated --------
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")) {
    Write-Host "Not running as Administrator. Relaunching elevated..." -ForegroundColor Yellow
    Start-Process powershell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

# ---- Header ------------------------------------------------
Clear-Host
Write-Host "============================================" -ForegroundColor DarkGray
Write-Host "  Windows WiFi Diagnostics Tool" -ForegroundColor Cyan
Write-Host "  by Manish Sharma" -ForegroundColor Yellow
Write-Host "============================================" -ForegroundColor DarkGray
Write-Host ""

# ---- Output paths ------------------------------------------
$scriptDir  = if ($PSScriptRoot) { $PSScriptRoot } else { $PWD.Path }
$timestamp  = Get-Date -Format "yyyyMMdd_HHmmss"
$outputTxt  = Join-Path $scriptDir "WiFi_Diagnostics_$timestamp.txt"
$wlanHtml   = Join-Path $scriptDir "WiFi_WLANReport_$timestamp.html"
$zipFile    = Join-Path $scriptDir "WiFi_Report_$timestamp.zip"

# ---- File header -------------------------------------------
@"
Windows WiFi Diagnostics Tool Report
Generated : $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')
User      : $env:USERNAME
Computer  : $env:COMPUTERNAME
============================================

"@ | Out-File $outputTxt -Encoding utf8

# ---- Helper function ---------------------------------------
function Invoke-AndLog {
    param(
        [string]$Label,
        [string]$Command
    )

    Write-Host "Running: $Label" -ForegroundColor Cyan

    # Write section header to file
    @"
============================================
$Label
============================================
"@ | Out-File $outputTxt -Append -Encoding utf8

    # Run command, capture stdout + stderr
    $output = Invoke-Expression $Command 2>&1 | Out-String

    # Show in console
    Write-Host $output
    Write-Host "---" -ForegroundColor DarkGray

    # Save to file
    $output | Out-File $outputTxt -Append -Encoding utf8
    "" | Out-File $outputTxt -Append -Encoding utf8
}

# ============================================================
# SECTION 1 - Basic Connectivity
# ============================================================
Invoke-AndLog "Date / Time"                         "Get-Date"
Invoke-AndLog "IP Configuration"                    "ipconfig /all"
Invoke-AndLog "Routing Table"                       "route print"

# ---- Connectivity ping with explicit count -----------------
Invoke-AndLog "Ping 8.8.8.8 (4 packets)"           "ping -n 4 8.8.8.8"
Invoke-AndLog "Traceroute to 8.8.8.8"              "tracert -d -w 400 -h 30 8.8.8.8"
Invoke-AndLog "DNS Lookup (google.com)"             "nslookup google.com"
Invoke-AndLog "WinHTTP Proxy Settings"              "netsh winhttp show proxy"

# ============================================================
# SECTION 2 - MTU Tests
# NOTE: 1472 bytes + 28 byte IP/ICMP header = 1500 (standard MTU)
#       If 1472 passes but 1500 fails, fragmentation is occurring.
#       If both fail, MTU may be lower than 1500 - common on VPNs/PPPoE.
# ============================================================
Invoke-AndLog "MTU Test - 1472 bytes (target: no fragmentation)" "ping -n 4 -f -l 1472 8.8.8.8"
Invoke-AndLog "MTU Test - 1500 bytes (expect failure if MTU=1500)" "ping -n 4 -f -l 1500 8.8.8.8"

# ============================================================
# SECTION 3 - WiFi Adapter & Driver Info
# ============================================================
Invoke-AndLog "WLAN Drivers"                        "netsh wlan show drivers"
Invoke-AndLog "WLAN Interfaces"                     "netsh wlan show interfaces"
Invoke-AndLog "Wireless Capabilities"               "netsh wlan show wirelesscapabilities"
Invoke-AndLog "Autoconfig Status"                   "netsh wlan show autoconfig"
Invoke-AndLog "WLAN Settings"                       "netsh wlan show settings"
Invoke-AndLog "MAC Randomization"                   "netsh wlan show randomization"
Invoke-AndLog "Tracing Status"                      "netsh wlan show tracing"

# ============================================================
# SECTION 4 - Networks & Profiles
# ============================================================
Invoke-AndLog "Visible Networks (with BSSID)"       "netsh wlan show networks mode=bssid"
Invoke-AndLog "Saved WiFi Profiles"                 "netsh wlan show profiles"
Invoke-AndLog "Filters"                             "netsh wlan show filters"
Invoke-AndLog "Blocked Networks"                    "netsh wlan show blockednetworks"
Invoke-AndLog "Hosted Network"                      "netsh wlan show hostednetwork"

# ============================================================
# SECTION 5 - Full WLAN Report (Windows built-in)
# ============================================================
Invoke-AndLog "Generate WLAN Report"                "netsh wlan show wlanreport"

$wlanReportSource = "C:\ProgramData\Microsoft\Windows\WlanReport\wlan-report-latest.html"
if (Test-Path $wlanReportSource) {
    Copy-Item -Path $wlanReportSource -Destination $wlanHtml -Force
    Write-Host "Copied WLAN HTML report -> $wlanHtml" -ForegroundColor Green
    "WLAN HTML report copied to: $wlanHtml" | Out-File $outputTxt -Append -Encoding utf8
} else {
    Write-Host "WLAN HTML report not found at expected path." -ForegroundColor Red
    "WARNING: WLAN HTML report not found at $wlanReportSource" | Out-File $outputTxt -Append -Encoding utf8
}

# ============================================================
# ZIP both output files into a single archive
# ============================================================
Write-Host ""
Write-Host "Creating ZIP archive..." -ForegroundColor Cyan

$filesToZip = @($outputTxt)
if (Test-Path $wlanHtml) { $filesToZip += $wlanHtml }

try {
    Compress-Archive -Path $filesToZip -DestinationPath $zipFile -Force
    Write-Host "ZIP created -> $zipFile" -ForegroundColor Green
} catch {
    Write-Host "Failed to create ZIP: $_" -ForegroundColor Red
}

# ============================================================
# Done
# ============================================================
Write-Host ""
Write-Host "============================================" -ForegroundColor DarkGray
Write-Host "  All diagnostics complete!" -ForegroundColor Green
Write-Host "  Report saved to:" -ForegroundColor White
Write-Host "  $zipFile" -ForegroundColor Yellow
Write-Host "============================================" -ForegroundColor DarkGray
Write-Host ""
Write-Host "Copyright (c) $(Get-Date -Format yyyy) Manish Sharma. All rights reserved." -ForegroundColor DarkGray
Write-Host ""
Write-Host "Window will close in 15 seconds..." -ForegroundColor Gray
Start-Sleep -Seconds 15
