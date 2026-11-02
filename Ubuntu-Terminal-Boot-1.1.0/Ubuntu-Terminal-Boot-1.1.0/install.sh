#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
APP_DIR="$HOME/.local/share/ubuntu-terminal-boot"

mkdir -p "$APP_DIR"
install -m 0755 "$SCRIPT_DIR/boot.sh" "$APP_DIR/boot.sh"
install -m 0755 "$SCRIPT_DIR/manage-autostart.sh" "$APP_DIR/manage-autostart.sh"

"$APP_DIR/manage-autostart.sh" on

echo
echo "Ubuntu Terminal Boot berhasil dipasang."
echo "UTB akan berjalan saat terminal Ubuntu WSL dibuka."
echo
echo "Matikan auto-start:"
echo "  $APP_DIR/manage-autostart.sh off"
echo
echo "Aktifkan lagi:"
echo "  $APP_DIR/manage-autostart.sh on"
echo
echo "Lihat status:"
echo "  $APP_DIR/manage-autostart.sh status"
echo
echo "Tutup lalu buka kembali terminal Ubuntu untuk mencoba."
