# Ubuntu Terminal Boot 1.1.0

Launcher terminal bergaya boot untuk Ubuntu yang berjalan di WSL2.

## Fitur

- Menampilkan logo teks Ubuntu dan informasi versi.
- Menampilkan beberapa log sistem terbaru dari `journalctl`.
- Mendeteksi akun pengguna biasa secara otomatis.
- Menampilkan nama lengkap dan username akun.
- Memakai autentikasi Ubuntu melalui `su`/PAM.
- Tidak menampilkan pilihan `q. Exit`.
- `Ctrl+C` menghentikan UTB. Karena UTB dijalankan dengan `exec` dari konfigurasi shell, sesi terminal akan berakhir.
- Auto-start dapat diaktifkan atau dinonaktifkan.

## Instalasi

1. Ekstrak ZIP ini di Ubuntu/WSL atau letakkan foldernya di lokasi yang mudah ditemukan.
2. Buka terminal Ubuntu.
3. Masuk ke folder hasil ekstrak, misalnya:

   ```bash
   cd ~/Downloads/Ubuntu-Terminal-Boot-1.1.0
   ```

4. Jalankan:

   ```bash
   chmod +x install.sh
   ./install.sh
   ```

5. Tutup terminal Ubuntu, lalu buka kembali.

## Mengatur auto-start

File pengelola berada di:

```bash
~/.local/share/ubuntu-terminal-boot/manage-autostart.sh
```

Matikan auto-start (UTB tetap terpasang):

```bash
~/.local/share/ubuntu-terminal-boot/manage-autostart.sh off
```

Aktifkan kembali:

```bash
~/.local/share/ubuntu-terminal-boot/manage-autostart.sh on
```

Periksa status:

```bash
~/.local/share/ubuntu-terminal-boot/manage-autostart.sh status
```

## Menghapus UTB

```bash
cd ~/Downloads/Ubuntu-Terminal-Boot-1.1.0
./uninstall.sh
```

Penghapusan menonaktifkan auto-start dan menghapus berkas UTB. Cadangan `.bashrc.backup-utb` dibiarkan tetap ada.

## Catatan penting

- Auto-start berjalan ketika sesi shell interaktif Ubuntu WSL dibuka. Ini bukan proses boot firmware/BIOS dan bukan pengganti login manager Linux.
- WSL sudah memulai sesi pengguna default sebelum UTB berjalan. UTB adalah launcher/pemilih akun, bukan batas keamanan yang mengunci akses ke WSL atau Windows.
- `su` mungkin tidak meminta kata sandi saat memilih akun yang sama dengan akun yang sedang menjalankan WSL. Akun lain akan mengikuti aturan autentikasi Ubuntu/PAM.
- Nama akun ditampilkan dari data akun lokal (GECOS); bila nama lengkap kosong, UTB menampilkan username.
- UTB tidak menyimpan atau meminta kata sandi untuk dimasukkan ke dalam berkas.
- Log yang ditampilkan adalah log terbaru yang tersedia, bukan rekaman proses boot langsung.
- Paket ini ditujukan untuk Ubuntu di WSL2 dengan Bash, `su`, `getent`, dan 
