#!/usr/bin/env bash
set -u

ORANGE='\033[38;5;208m'
GREEN='\033[38;5;82m'
WHITE='\033[1;37m'
GRAY='\033[38;5;245m'
RED='\033[38;5;196m'
RESET='\033[0m'

# Ctrl+C, EOF, or terminal close ends this launcher.
trap 'printf "\n${GRAY}UTB ditutup.${RESET}\n"; exit 0' INT TERM HUP

clear
printf "${ORANGE}"
cat <<'LOGO'
        ╭──────────────────────────────╮
        │                              │
        │        ●           ●         │
        │                              │
        │    ●      UBUNTU      ●      │
        │                              │
        │        ●           ●         │
        │                              │
        ╰──────────────────────────────╯

         UBUNTU TERMINAL BOOT SYSTEM
LOGO
printf "${WHITE}          26.04 LTS${RESET}\n"
printf "${GRAY}       RESOLUTE RACCOON${RESET}\n\n"
sleep 1

printf "${ORANGE}========== RECENT SYSTEM LOGS ==========${RESET}\n\n"
if command -v journalctl >/dev/null 2>&1 && journalctl -b -n 1 --no-pager >/dev/null 2>&1; then
    journalctl -b -n 12 --no-pager -o short-iso 2>/dev/null |
    while IFS= read -r line; do
        printf "${GRAY}%s${RESET}\n" "$line"
        sleep 0.18
    done
else
    printf "${GRAY}Log sistem tidak dapat dibaca pada sesi ini.${RESET}\n"
fi

printf "\n${GREEN}Tampilan log selesai.${RESET}\n"
sleep 1

while true; do
    clear
    printf "${ORANGE}====================================${RESET}\n"
    printf "${WHITE}          UBUNTU LOGIN${RESET}\n"
    printf "${ORANGE}====================================${RESET}\n\n"

    mapfile -t USERS < <(
        getent passwd |
        awk -F: '
        $3 >= 1000 && $3 < 60000 &&
        $6 ~ /^\/home\// &&
        $7 !~ /nologin|false/ {
            print $1
        }'
    )

    if (( ${#USERS[@]} == 0 )); then
        printf "${RED}Tidak ada akun pengguna yang memenuhi syarat.${RESET}\n"
        sleep 3
        exit 1
    fi

    printf "${WHITE}PILIH AKUN${RESET}\n\n"
    for i in "${!USERS[@]}"; do
        USERNAME="${USERS[$i]}"
        FULLNAME="$(getent passwd "$USERNAME" | cut -d: -f5)"
        FULLNAME="${FULLNAME%%,*}"
        [[ -n "$FULLNAME" ]] || FULLNAME="$USERNAME"
        printf "  ${GREEN}%d.${RESET} %s (%s)\n" "$((i+1))" "$FULLNAME" "$USERNAME"
    done

    printf "\n"
    read -r -p "Pilih akun: " CHOICE || exit 0

    if [[ ! "$CHOICE" =~ ^[0-9]+$ ]]; then
        printf "${RED}Pilihan tidak valid.${RESET}\n"
        sleep 1
        continue
    fi

    CHOICE_NUM=$((10#$CHOICE))
    if (( CHOICE_NUM < 1 || CHOICE_NUM > ${#USERS[@]} )); then
        printf "${RED}Akun tidak ditemukan.${RESET}\n"
        sleep 1
        continue
    fi

    SELECTED="${USERS[$((CHOICE_NUM-1))]}"
    clear
    printf "${ORANGE}UBUNTU AUTHENTICATION${RESET}\n\n"
    printf "Akun: %s\n" "$SELECTED"
    printf "${GRAY}Verifikasi kata sandi ditangani oleh Ubuntu PAM.${RESET}\n\n"

    # The marker prevents the selected account's shell from launching UTB again.
    /usr/bin/su - "$SELECTED" -c 'UTB_SKIP_AUTOSTART=1 exec "${SHELL:-/bin/bash}" -l'
    printf "\n${GRAY}Sesi akun berakhir. Kembali ke menu akun...${RESET}\n"
    sleep 1
done
