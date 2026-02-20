@echo off
:: ============================================================
:: Windows WiFi Diagnostics Launcher
:: by Manish Sharma
:: ============================================================
:: This launcher bypasses PowerShell execution policy
:: for this single run only. No system settings are changed.
:: ============================================================

title WiFi Diagnostics Tool

PowerShell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0WiFi_Diagnostics.ps1"

:: If PowerShell exits with an error, pause so the user can read it
if %ERRORLEVEL% NEQ 0 (
    echo.
    echo Something went wrong. Exit code: %ERRORLEVEL%
    pause
)
