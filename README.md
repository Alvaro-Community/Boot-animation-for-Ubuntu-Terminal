# Ubuntu Terminal Boot 1.1.0

**Ubuntu Terminal Boot (UTB)** adalah launcher terminal bergaya boot untuk Ubuntu yang berjalan di WSL2.

## 🎬 Demo Ubuntu Terminal Boot

![Ubuntu Terminal Boot Demo](./Demo.gif)

## 📥 Download & Install UTB di Ubuntu WSL

### 1. Download UTB

Buka halaman GitHub Releases:

[⬇️ Download Ubuntu Terminal Boot](../../releases/latest)

Download file **Ubuntu-Terminal-Boot-1.1.0.tar.gz** ke folder Downloads Windows.

### 2. Buka Ubuntu WSL

Buat folder Downloads di Ubuntu:

```bash
mkdir -p ~/Downloads
```

### 3. Pindahkan file dari Windows ke Ubuntu

```bash
WIN_USER="$(powershell.exe -NoProfile -Command '$env:USERNAME' | tr -d '\r')"
cp "/mnt/c/Users/$WIN_USER/Downloads/Ubuntu-Terminal-Boot-1.1.0.tar.gz" ~/Downloads/
```

### 4. Ekstrak file

```bash
cd ~/Downloads
tar -xzf Ubuntu-Terminal-Boot-1.1.0.tar.gz
```

### 5. Masuk ke folder UTB

```bash
cd ~/Downloads/Ubuntu-Terminal-Boot-1.1.0
```

### 6. Jalankan installer

```bash
bash install.sh
```

Tutup terminal Ubuntu, lalu buka kembali untuk mencoba UTB.

## ✨ Fitur

- Menampilkan logo teks Ubuntu dan informasi versi.
- Menampilkan log sistem terbaru dari `journalctl`.
- Mendeteksi akun pengguna Ubuntu secara otomatis.
- Menampilkan nama lengkap dan username akun.
- Menggunakan autentikasi Ubuntu melalui `su`/PAM.
- Tidak menyediakan pilihan `q. Exit`.
- Mendukung penghentian UTB dengan `Ctrl+C`.
- Auto-start dapat diaktifkan atau dinonaktifkan.

## ⚙️ Mengatur Auto-start

File pengelola auto-start:

```bash
~/.local/share/ubuntu-terminal-boot/manage-autostart.sh
```

**Mematikan auto-start:**

```bash
~/.local/share/ubuntu-terminal-boot/manage-autostart.sh off
```

**Mengaktifkan kembali:**

```bash
~/.local/share/ubuntu-terminal-boot/manage-autostart.sh on
```

**Memeriksa status:**

```bash
~/.local/share/ubuntu-terminal-boot/manage-autostart.sh status
```

## 🗑️ Menghapus UTB

Masuk ke folder hasil ekstrak UTB, kemudian jalankan:

```bash
bash uninstall.sh
```

Perintah ini menonaktifkan auto-start dan menghapus berkas UTB yang terpasang.

## 📝 Catatan Penting

- Auto-start berjalan ketika shell interaktif Ubuntu WSL dibuka. Ini bukan proses boot BIOS atau pengganti login manager Linux.
- WSL sudah memulai sesi pengguna default sebelum UTB berjalan.
- UTB bukan sistem keamanan yang mengunci akses ke WSL atau Windows.
- `su` mungkin tidak meminta kata sandi ketika memilih akun yang sama dengan akun aktif.
- Nama akun diambil dari data pengguna Ubuntu. Jika nama lengkap kosong, UTB menampilkan username.
- UTB tidak menyimpan kata sandi pengguna.
- Log yang ditampilkan merupakan log terbaru yang tersedia, bukan rekaman boot langsung.
- UTB ditujukan untuk Ubuntu WSL2 dengan Bash, `su`, `getent`, dan `journalctl`.

## 📦 Teknologi

- Ubuntu
- WSL2
- Bash Shell Script
- systemd / journalctl
- PAM / su

## 📄 License

Tambahkan informasi lisensi proyek di sini sebelum mendistribusikannya.
