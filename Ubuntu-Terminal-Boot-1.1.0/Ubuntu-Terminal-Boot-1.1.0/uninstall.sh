#!/usr/bin/env bash
set -euo pipefail

APP_DIR="$HOME/.local/share/ubuntu-terminal-boot"

if [[ -x "$APP_DIR/manage-autostart.sh" ]]; then
    "$APP_DIR/manage-autostart.sh" off
else
    echo "Pengaturan auto-start tidak ditemukan."
fi

rm -rf -- "$APP_DIR"
echo "Ubuntu Terminal Boot telah dihapus."
echo "Cadangan .bashrc.backup-utb tidak dihapus."
