// ============================================================
// ISI DUA NILAI DI BAWAH INI dengan milik project Supabase kamu.
// Lokasinya: Supabase Dashboard > Project Settings > API
// ============================================================
const SUPABASE_URL = "https://ISI-PROJECT-ID-KAMU.supabase.co";
const SUPABASE_ANON_KEY = "ISI-ANON-PUBLIC-KEY-KAMU";

// Jangan diubah — ini membuat koneksi ke Supabase yang dipakai
// oleh semua halaman.
const supabaseClient = supabase.createClient(SUPABASE_URL, SUPABASE_ANON_KEY);
