// Dipakai di semua halaman staf (setelah login) supaya menu sidebar
// konsisten dan tidak perlu ditulis ulang di tiap halaman.

const MENU_SIDEBAR = [
  { key: 'beranda', label: 'Beranda', href: 'beranda.html' },
  { key: 'pasien', label: 'Daftar Pasien', href: 'dashboard.html' },
  { key: 'jadwal', label: 'Jadwal Fisioterapi', href: 'jadwal.html' },
  { key: 'tambah', label: 'Tambah Pasien', href: 'tambah-pasien.html' },
];

function renderSidebar(activeKey) {
  const root = document.getElementById('sidebar-root');
  if (!root) return;

  const navHtml = MENU_SIDEBAR.map(item => `
    <a href="${item.href}" class="${item.key === activeKey ? 'active' : ''}">${item.label}</a>
  `).join('');

  root.innerHTML = `
    <div class="sidebar-brand">Klinik Fisioterapi</div>
    <nav class="sidebar-nav">${navHtml}</nav>
    <a href="#" class="sidebar-logout" id="btn-logout-sidebar">Keluar</a>
  `;

  document.getElementById('btn-logout-sidebar').addEventListener('click', async (e) => {
    e.preventDefault();
    await supabaseClient.auth.signOut();
    window.location.href = 'login.html';
  });
}

async function wajibLogin() {
  const { data } = await supabaseClient.auth.getSession();
  if (!data.session) {
    window.location.href = 'login.html';
    return false;
  }
  return true;
}
