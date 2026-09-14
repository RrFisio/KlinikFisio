// ============================================================
// ISI DUA NILAI DI BAWAH INI dengan milik project Supabase kamu.
// Lokasinya: Supabase Dashboard > Project Settings > API
// ============================================================
const SUPABASE_URL = "https://wlzeinwvtdgbbhorqhzs.supabase.co";
const SUPABASE_ANON_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndsemVpbnd2dGRnYmJob3JxaHpzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODkzNjE1MDQsImV4cCI6MjEwNDkzNzUwNH0.YeckMdGReYlIzuhCYCb0KoKpbhEGsAmnp2Sky_51XKk";

// Jangan diubah — ini membuat koneksi ke Supabase yang dipakai
// oleh semua halaman.
const supabaseClient = supabase.createClient(SUPABASE_URL, SUPABASE_ANON_KEY);
