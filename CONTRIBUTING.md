# Contributing to Windows WiFi Diagnostics Tool

Thank you for taking the time to contribute! Whether you're fixing a bug, suggesting an improvement, or adding a new diagnostic command — all contributions are welcome and appreciated.

Please take a moment to read these guidelines before getting started.

---

## 📋 Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Ways to Contribute](#ways-to-contribute)
- [Reporting Bugs](#reporting-bugs)
- [Suggesting Enhancements](#suggesting-enhancements)
- [Submitting a Pull Request](#submitting-a-pull-request)
- [Coding Guidelines](#coding-guidelines)
- [Commit Message Style](#commit-message-style)

---

## Code of Conduct

This project follows a [Code of Conduct](CODE_OF_CONDUCT.md). By participating, you agree to uphold it. Please report unacceptable behaviour through GitHub.

---

## Ways to Contribute

You don't have to write code to contribute. Here are some ways to help:

- 🐛 **Report a bug** — something not working as expected
- 💡 **Suggest a feature** — a new diagnostic command or output improvement
- 📖 **Improve documentation** — fix typos, clarify instructions, improve the README
- 🧪 **Test on different hardware** — try it on different WiFi adapters, Windows versions, or language locales and report your findings
- 🔍 **Review pull requests** — provide feedback on open PRs

---

## Reporting Bugs

Before submitting a bug report, please:

1. Check the [existing issues](../../issues) to see if it has already been reported
2. Make sure you are running the tool as Administrator (UAC prompt must be accepted)
3. Confirm you are on Windows 10 or Windows 11 with PowerShell 5.1+

When opening a bug report, please include:

- Your Windows version (e.g. Windows 11 23H2)
- PowerShell version (`$PSVersionTable.PSVersion` in PowerShell)
- What you expected to happen
- What actually happened
- Any error messages shown in the console or output file
- Whether you have a WiFi adapter present and enabled

> **Please do not include your WiFi report output files in public issues** — they may contain your network names, IP addresses, or other sensitive information.

---

## Suggesting Enhancements

Open a GitHub issue with the label `enhancement` and describe:

- What the new diagnostic command or feature would do
- Why it would be useful for troubleshooting
- Any relevant `netsh`, `ipconfig`, or PowerShell commands you have in mind

---

## Submitting a Pull Request

1. **Fork** the repository and create a new branch from `main`:
   ```
   git checkout -b feature/your-feature-name
   ```

2. **Make your changes** following the coding guidelines below

3. **Test your changes** by running the full tool on a Windows machine and verifying:
   - The script runs without errors (both with and without a WiFi adapter)
   - The `.txt` report is complete and readable
   - The `.zip` file is created successfully
   - Admin elevation works correctly

4. **Commit your changes** with a clear commit message (see style guide below)

5. **Open a Pull Request** against the `main` branch with:
   - A clear title and description of what you changed and why
   - Reference to any related issue (e.g. `Closes #12`)

---

## Coding Guidelines

Since this project is PowerShell-based, please follow these conventions:

- **Use `$PSScriptRoot`** instead of `$MyInvocation.MyCommand.Path` for path resolution
- **Avoid `Invoke-Expression`** where possible — prefer direct cmdlet calls
- **Always specify `-n` / `-w` / `-h` flags** on ping and tracert to prevent indefinite hangs
- **Add a descriptive label** when using `Invoke-AndLog` — the label appears as a section header in the report
- **Add inline comments** for any non-obvious behaviour (e.g. MTU test explanations)
- **Do not collect sensitive data** — no passwords, PSKs, browser data, or personal files
- Keep the script a **single `.ps1` file** paired with a **single `.bat` launcher** — do not introduce additional dependencies

---

## Commit Message Style

Use short, clear commit messages in the imperative mood:

```
Add netsh lan show interfaces for wired adapter info
Fix ping timeout on machines with no internet access
Remove duplicate netsh wlan show all command
Update README with MTU test explanation
```

Avoid vague messages like `fix stuff`, `update`, or `changes`.

---

Thank you for helping make this tool better! 🙏
