#!/usr/bin/env bash
set -euo pipefail

APP_DIR="$HOME/.local/share/ubuntu-terminal-boot"
BASHRC="$HOME/.bashrc"
START_MARKER="# >>> UBUNTU TERMINAL BOOT AUTOSTART >>>"
END_MARKER="# <<< UBUNTU TERMINAL BOOT AUTOSTART <<<"

enable_autostart() {
    touch "$BASHRC"
    if grep -Fq "$START_MARKER" "$BASHRC"; then
        echo "Auto-start UTB sudah aktif."
        return 0
    fi

    cp -n "$BASHRC" "$BASHRC.backup-utb" 2>/dev/null || true
    cat >> "$BASHRC" <<'HOOK'

# >>> UBUNTU TERMINAL BOOT AUTOSTART >>>
if [[ $- == *i* ]] &&
   [[ -z "${UTB_SKIP_AUTOSTART:-}" ]] &&
   [[ -n "${WSL_DISTRO_NAME:-}" ]] &&
   [[ -x "$HOME/.local/share/ubuntu-terminal-boot/boot.sh" ]]; then
    exec "$HOME/.local/share/ubuntu-terminal-boot/boot.sh"
fi
# <<< UBUNTU TERMINAL BOOT AUTOSTART <<<
HOOK
    echo "Auto-start UTB diaktifkan."
}

disable_autostart() {
    if [[ ! -f "$BASHRC" ]] || ! grep -Fq "$START_MARKER" "$BASHRC"; then
        echo "Auto-start UTB sudah nonaktif."
        return 0
    fi

    tmp="$(mktemp)"
    awk -v start="$START_MARKER" -v end="$END_MARKER" '
        $0 == start { skip=1; next }
        $0 == end   { skip=0; next }
        !skip       { print }
    ' "$BASHRC" > "$tmp"
    cat "$tmp" > "$BASHRC"
    rm -f "$tmp"
    echo "Auto-start UTB dinonaktifkan. File UTB tetap tersimpan."
}

case "${1:-status}" in
    on|enable) enable_autostart ;;
    off|disable) disable_autostart ;;
    status)
        if grep -Fq "$START_MARKER" "$BASHRC" 2>/dev/null; then
            echo "Auto-start UTB: AKTIF"
        else
            echo "Auto-start UTB: NONAKTIF"
        fi
        ;;
    *)
        echo "Penggunaan: $0 {on|off|status}"
        exit 2
        ;;
esac
