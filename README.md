# Ubuntu Terminal Boot (UTB) 1.1.0

A terminal boot-style launcher for **Ubuntu on WSL2**.

> **Status:** This project is designed for Ubuntu running under WSL2. It is a shell launcher, not a replacement for the Linux boot process or a secure system login manager.

## 🎬 Demo

![Ubuntu Terminal Boot demo](./Demo.gif)

## ✨ Features

- Ubuntu-inspired terminal startup screen.
- Displays recent system journal entries with `journalctl`.
- Detects eligible local user accounts automatically.
- Shows each account's display name and username.
- Opens the selected account using Ubuntu's `su`/PAM authentication.
- Optional automatic launch when an interactive WSL Bash shell starts.
- Commands to enable or disable automatic launch.

## 📥 Download

1. Open this repository's **Releases** page.
2. Open the release for **UTB 1.1.0**.
3. Under **Assets**, download:

   `Boot-animation-for-Ubuntu-Terminal-1.1.0.zip`

   Download the release asset, not GitHub's automatically generated **Source code** archive.

## 🪟 Install from Windows Downloads into Ubuntu WSL

These instructions assume the ZIP file was saved in the Windows user's **Downloads** folder.

### 1. Open Ubuntu (WSL)

Open your Ubuntu distribution from the Windows Start menu.

### 2. Make a Downloads folder in Ubuntu

```bash
mkdir -p ~/Downloads
```

### 3. Extract the ZIP from Windows Downloads

Replace `WINDOWS_USERNAME` with the name of your Windows profile folder.

For example, if your Windows Downloads folder is `C:\Users\Alvaro\Downloads`, use `Alvaro`.

```bash
unzip "/mnt/c/Users/WINDOWS_USERNAME/Downloads/Boot-animation-for-Ubuntu-Terminal-1.1.0.zip" -d ~/Downloads/UTB
```

If `unzip` is not installed, install it first:

```bash
sudo apt update
sudo apt install unzip
```

Then run the extraction command again.

### 4. Find the installer

This command finds `install.sh` even if the ZIP contains an extra folder level:

```bash
find ~/Downloads/UTB -type f -name install.sh -print
```

### 5. Run the installer

These commands locate the installer automatically and start it:

```bash
INSTALLER="$(find ~/Downloads/UTB -type f -name install.sh -print -quit)"
if [ -z "$INSTALLER" ]; then
    echo "install.sh was not found. Check the extracted ZIP contents."
else
    cd "$(dirname "$INSTALLER")" && bash install.sh
fi
```

When installation finishes, close the Ubuntu terminal window or tab and open Ubuntu again to test automatic launch.

## ⚙️ Manage automatic launch

The installer places UTB in:

```text
~/.local/share/ubuntu-terminal-boot
```

Check whether automatic launch is enabled:

```bash
~/.local/share/ubuntu-terminal-boot/manage-autostart.sh status
```

Disable automatic launch (UTB remains installed):

```bash
~/.local/share/ubuntu-terminal-boot/manage-autostart.sh off
```

Enable automatic launch again:

```bash
~/.local/share/ubuntu-terminal-boot/manage-autostart.sh on
```

## 🗑️ Uninstall

Go to the extracted UTB folder and run its uninstaller:

```bash
bash uninstall.sh
```

If you no longer know where the extracted folder is, find it with:

```bash
find ~/Downloads/UTB -type f -name uninstall.sh -print
```

The uninstaller disables the UTB auto-start hook and removes the installed UTB program files. It does not delete Ubuntu itself or your Ubuntu user accounts.

## 📝 Important notes and limitations

- Auto-start runs when an interactive Bash shell starts in WSL. It is not a BIOS/firmware boot screen and does not replace a Linux display or login manager.
- WSL starts its default Linux user session before UTB runs. UTB is a launcher and account selector, **not a security boundary** that locks Windows or WSL.
- `su` may not ask for a password when the currently logged-in user selects their own account. Authentication behavior follows the system's `su` and PAM configuration.
- Recent journal entries are displayed; this is not a live recording of the boot process.
- Account display names are read from local account information. If no display name is set, UTB shows the username.
- UTB does not store users' passwords.
- This release may display `cannot set terminal process group` or `no job control` when opening a selected account. These messages indicate a terminal job-control issue in the current launcher; they do not necessarily mean the password was rejected. This issue should be fixed before describing the release as production-ready.
- The Windows-to-WSL path `/mnt/c/...` assumes that the Windows C: drive is mounted in WSL using the default mount configuration.

## 🧰 Requirements

- Windows with WSL2 enabled.
- An Ubuntu WSL distribution.
- Bash.
- `su`, `getent`, and `journalctl`.
- `unzip` to extract the release package.

## 📄 License

No license has been specified yet. Unless a license is added to this repository, others do not automatically receive permission to redistribute or modify the project.
