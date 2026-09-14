-- ============================================================
-- SKEMA DATABASE — Aplikasi Klinik Fisioterapi
-- Jalankan seluruh isi file ini di Supabase Dashboard:
-- Project kamu > SQL Editor > New query > paste semua > Run
-- ============================================================

-- Ekstensi untuk membuat UUID otomatis
create extension if not exists "pgcrypto";

-- ------------------------------------------------------------
-- Tabel: pasien
-- ------------------------------------------------------------
create table if not exists pasien (
  id uuid primary key default gen_random_uuid(),
  nama text not null,
  tanggal_lahir date not null,
  alamat text not null,
  keluhan text not null,
  created_at timestamptz not null default now()
);

-- ------------------------------------------------------------
-- Tabel: jadwal_fisioterapi
-- ------------------------------------------------------------
create table if not exists jadwal_fisioterapi (
  id uuid primary key default gen_random_uuid(),
  pasien_id uuid not null references pasien(id) on delete cascade,
  tanggal date not null,
  jam time not null,
  jenis_tindakan text,
  status text not null default 'terjadwal', -- terjadwal | selesai | batal
  catatan text,
  created_at timestamptz not null default now()
);

-- ------------------------------------------------------------
-- Tabel: riwayat_tindakan
-- (dicatat oleh terapis setelah sesi berlangsung)
-- ------------------------------------------------------------
create table if not exists riwayat_tindakan (
  id uuid primary key default gen_random_uuid(),
  pasien_id uuid not null references pasien(id) on delete cascade,
  tanggal date not null,
  tindakan text not null,
  catatan text,
  terapis text,
  created_at timestamptz not null default now()
);

-- Index bantu supaya query per pasien cepat
create index if not exists idx_jadwal_pasien on jadwal_fisioterapi(pasien_id);
create index if not exists idx_riwayat_pasien on riwayat_tindakan(pasien_id);

-- ============================================================
-- ROW LEVEL SECURITY (RLS)
-- Aturan: publik (tanpa login) HANYA boleh INSERT data pasien
-- baru (mengisi formulir). Semua akses baca/tulis lain hanya
-- untuk staf yang sudah login (authenticated).
-- ============================================================

alter table pasien enable row level security;
alter table jadwal_fisioterapi enable row level security;
alter table riwayat_tindakan enable row level security;

-- Tabel pasien -------------------------------------------------

-- 1) Siapa saja (anon) boleh menambahkan data pasien baru (formulir publik)
create policy "publik_boleh_isi_formulir"
on pasien for insert
to anon
with check (true);

-- 2) Staf yang login boleh melihat, menambah, mengubah, menghapus data pasien
create policy "staf_akses_penuh_pasien"
on pasien for all
to authenticated
using (true)
with check (true);

-- Tabel jadwal_fisioterapi --------------------------------------

-- Hanya staf yang login yang boleh mengelola jadwal
create policy "staf_akses_penuh_jadwal"
on jadwal_fisioterapi for all
to authenticated
using (true)
with check (true);

-- Tabel riwayat_tindakan ------------------------------------------

-- Hanya staf yang login yang boleh mengelola riwayat tindakan
create policy "staf_akses_penuh_riwayat"
on riwayat_tindakan for all
to authenticated
using (true)
with check (true);

-- ============================================================
-- AKUN STAF
-- Buat akun login staf lewat:
-- Supabase Dashboard > Authentication > Users > Add user
-- (isi email & password staf klinik di sana, bukan lewat SQL ini)
-- ============================================================
