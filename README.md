# Aplikasi Klinik Fisioterapi

Aplikasi sederhana untuk klinik fisioterapi:
- Pasien mengisi formulir pendaftaran sendiri (tanpa login) di `index.html`
- Staf klinik login (`login.html`) untuk melihat daftar pasien (`dashboard.html`)
- Setiap pasien punya **Kartu Pasien** (`kartu.html`) berisi identitas, jadwal
  fisioterapi, dan riwayat tindakan — staf bisa menambah jadwal baru dan
  mencatat tindakan langsung dari halaman ini.

Tidak butuh server backend — semua langsung bicara ke Supabase dari browser,
sehingga bisa di-hosting gratis di GitHub Pages.

## 1. Siapkan database di Supabase

1. Buka project Supabase kamu.
2. Masuk ke **SQL Editor** → **New query**.
3. Salin seluruh isi file `schema.sql` di folder ini, tempel, lalu **Run**.
   Ini akan membuat 3 tabel (`pasien`, `jadwal_fisioterapi`,
   `riwayat_tindakan`) beserta aturan keamanan (RLS):
   - Siapa saja boleh mengisi formulir pendaftaran pasien.
   - Hanya staf yang login yang boleh melihat data pasien, mengatur jadwal,
     dan mencatat riwayat tindakan.

## 2. Buat akun login untuk staf

1. Di Supabase Dashboard, buka **Authentication → Users → Add user**.
2. Isi email & password untuk tiap staf klinik yang perlu akses.
   (Tidak perlu pasien didaftarkan sebagai user — hanya staf.)

## 3. Hubungkan aplikasi ke Supabase kamu

1. Di Supabase Dashboard, buka **Project Settings → API**.
2. Salin **Project URL** dan **anon public key**.
3. Buka file `assets/supabase-config.js`, isi dua nilai berikut:
   ```js
   const SUPABASE_URL = "https://xxxxx.supabase.co";
   const SUPABASE_ANON_KEY = "eyJhbGciOi...";
   ```

## 4. Deploy ke GitHub Pages

1. Buat repository baru di GitHub, lalu upload semua file di folder ini
   (`index.html`, `login.html`, `dashboard.html`, `kartu.html`, folder
   `assets/`, dst) ke repository tersebut.
2. Di repository, buka **Settings → Pages**.
3. Pada **Source**, pilih branch `main` dan folder `/ (root)`, lalu **Save**.
4. Tunggu 1-2 menit, GitHub akan memberi URL seperti:
   `https://namakamu.github.io/nama-repo/`
5. Buka URL tersebut — halaman pendaftaran pasien (`index.html`) akan
   langsung tampil. Staf bisa login lewat `.../login.html`.

## Struktur file

```
index.html                  → formulir pendaftaran pasien (publik)
login.html                  → login staf
dashboard.html               → daftar pasien (perlu login)
kartu.html                  → kartu pasien: identitas + jadwal + riwayat
assets/style.css            → tampilan
assets/supabase-config.js   → isi URL & anon key Supabase kamu di sini
schema.sql                  → jalankan sekali di Supabase SQL Editor
```

## Catatan keamanan

- `anon key` Supabase aman ditaruh di kode frontend — kunci ini memang
  didesain publik, keamanan sebenarnya diatur lewat RLS policy di `schema.sql`.
- Jangan pernah menaruh **service_role key** di file frontend manapun.

## Pengembangan lanjutan (opsional, belum dibuat)

- Edit/hapus data pasien dari dashboard
- Ubah status jadwal (terjadwal → selesai/batal) dari kartu pasien
- Ekspor riwayat pasien ke PDF
- Notifikasi WhatsApp/email pengingat jadwal
