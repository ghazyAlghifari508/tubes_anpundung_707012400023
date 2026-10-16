# Anpundung Mobile - Aplikasi Pengaduan Pungli Kota Bandung 🛡️🏛️

Aplikasi mobile berbasis Flutter yang dikembangkan sebagai solusi *Civic Engagement* dan transparansi publik untuk memfasilitasi pelaporan serta pemantauan tindak pungutan liar (pungli) di seluruh wilayah Kota Bandung secara cepat, akuntabel, dan terintegrasi dengan Satgas Saber Pungli.

---

## 👤 Identitas Mahasiswa
* **Nama Lengkap:** Ghazy Nabil Alghfari
* **NIM:** 707012400023
* **Kelas:** D4SIKC (48-03)
* **Program Studi:** D4 Sistem Informasi Kota Cerdas (D4SIKC)
* **Fakultas:** Fakultas Ilmu Terapan (FIT)
* **Perguruan Tinggi:** Universitas Telkom
* **Akun GitHub:** [@ghazyAlghifari508](https://github.com/ghazyAlghifari508)

---

## 🚀 Fitur Unggulan Aplikasi

1. **Struktur Navigasi Multi-Level & Adaptif:**
   - **Adaptive Navigation Layout:** Beralih otomatis antara `NavigationBar` (pada layar *portrait* <600dp) dan `NavigationRail` (pada layar *landscape* atau tablet $\ge$600dp).
   - **Side Navigation Drawer:** Panel laci navigasi dengan header profil warga, tautan Titik Rawan, Kontak Darurat, Panduan Hukum & Sanksi, serta Tentang Aplikasi.
   - **Tab Navigation (`DefaultTabController` & `TabBarView`):** Pengelompokan aduan berdasarkan 4 sektor vital: Parkir Liar, Pendidikan, Pasar & PKL, serta Kelurahan & Perizinan.
   - **BottomAppBar & Docked FAB:** Tampilan riwayat aduan dengan bilah navigasi bawah bertakik (`CircularNotchedRectangle`) dan tombol aksi melayang ("Lapor Kilat") di tengah.

2. **Pengelolaan Rute Lanjutan (Routing & Parameter Passing):**
   - **`onGenerateRoute`:** Ekstraksi argumen bertipe kuat (`RincianLaporanArguments`) untuk membuka rincian aduan secara dinamis.
   - **Pop Result Handling:** Pengiriman data balik saat rincian ditutup menggunakan `Navigator.pop(context, result)` yang kemudian direspon oleh Beranda melalui `SnackBar` interaktif.
   - **`onUnknownRoute` (Galat 404 Fallback):** Penanganan rute yang tidak terdaftar dengan antarmuka informatif dan tombol navigasi kembali ke beranda.
   - **Safety Back Navigation (`PopScope`):** Dialog konfirmasi cegah keluar aplikasi tanpa sengaja.

3. **Layanan Pengaduan & Informasi Publik:**
   - **Dashboard Statistik:** Ringkasan metrik aduan real-time (Total Laporan, Investigasi Lapangan, Penindakan Tegas).
   - **Formulir Pelaporan:** Input terstruktur dengan validasi ketat, estimasi nominal, lokasi, kronologi, dan opsi perlindungan privasi (Pelapor Anonim).
   - **Peta Titik Rawan:** Zona merah dan kuning pemantauan pungli di titik-titik krusial Kota Bandung.
   - **Hotline Darurat Saber Pungli:** Akses cepat ke Satgas Saber Pungli Bandung, Polrestabes, Kejaksaan Negeri, dan Inspektorat Daerah.
   - **Dasar Hukum & Whistleblower Protection:** Rujukan regulasi Perpres No. 87 Tahun 2016, KUHP Pasal 368 & 423, serta UU Perlindungan Saksi dan Korban (LPSK).

---

## 📁 Struktur Direktori Proyek

```text
tubes_anpundung_707012400023/
├── android/
├── lib/
│   ├── main.dart                          # Root MaterialApp & konfigurasi tema/rute
│   ├── navigation/
│   │   ├── app_routes.dart                # Konstanta rute, argument model, & onGenerateRoute
│   │   └── kerangka_navigasi.dart         # Scaffold utama, adaptive NavigationBar/Rail, Drawer, PopScope
│   └── pages/
│       ├── halaman_beranda.dart           # Dashboard metrik & daftar aduan terkini
│       ├── halaman_kategori_pungli.dart   # TabBar & TabBarView 4 kategori pungli
│       ├── halaman_profil_pelapor.dart    # Informasi akun warga pelapor & badge integritas
│       ├── halaman_rincian_laporan.dart   # Detail aduan dengan argumen & pop result
│       ├── halaman_buat_laporan.dart      # Formulir input aduan pungli baru
│       ├── halaman_riwayat_laporan.dart   # Riwayat aduan dengan BottomAppBar & docked FAB
│       ├── halaman_titik_rawan.dart       # Informasi zona rawan pungutan liar Kota Bandung
│       ├── halaman_kontak_darurat.dart    # Daftar kanal siaga & hotline Satgas Saber Pungli
│       ├── halaman_panduan_hukum.dart     # Payung hukum & regulasi perlindungan pelapor
│       └── halaman_tentang_aplikasi.dart  # Visi, misi, & informasi pengembang Anpundung
├── screenshots/                           # 17 Tangkapan layar pengujian antarmuka
├── test/
│   └── widget_test.dart                   # Automated Widget Tests (Navigasi, Tabs, Drawer, Rail)
├── pubspec.yaml
└── README.md
```

---

## 📸 Dokumentasi Tangkapan Layar (17 Screenshots)

| No | Nama Tampilan | Berkas Tangkapan Layar |
|:--:|:---|:---|
| 1 | Beranda Utama Anpundung & Metrik Aduan | `screenshots/01_beranda_anpundung.png` |
| 2 | Kategori Aduan: Parkir Liar | `screenshots/02_kategori_parkir_liar.png` |
| 3 | Kategori Aduan: Pendidikan & Sekolah | `screenshots/03_kategori_pendidikan.png` |
| 4 | Kategori Aduan: Pasar Tradisional & PKL | `screenshots/04_kategori_pasar_pkl.png` |
| 5 | Kategori Aduan: Kelurahan & Perizinan | `screenshots/05_kategori_kelurahan_izin.png` |
| 6 | Rincian Aduan Berparameter (`onGenerateRoute`) | `screenshots/06_rincian_aduan_pungli.png` |
| 7 | Notifikasi Aksi Aduan (`SnackBar` Pop Result) | `screenshots/07_pemberitahuan_snackbar.png` |
| 8 | Formulir Buat Aduan Pungli Baru | `screenshots/08_formulir_buat_laporan.png` |
| 9 | Profil Warga Pelapor & Lencana Integritas | `screenshots/09_profil_pelapor_warga.png` |
| 10 | Riwayat Aduan (`BottomAppBar` & Docked FAB) | `screenshots/10_riwayat_laporan_bottom_app_bar.png` |
| 11 | Laci Navigasi Samping (`NavigationDrawer`) | `screenshots/11_navigation_drawer_terbuka.png` |
| 12 | Informasi Titik Rawan Pungli Kota Bandung | `screenshots/12_titik_rawan_pungli.png` |
| 13 | Layanan Hotline & Kontak Darurat Satgas | `screenshots/13_kontak_darurat_satgas.png` |
| 14 | Panduan Regulasi Hukum & Sanksi Pidana | `screenshots/14_panduan_hukum_sanksi.png` |
| 15 | Informasi Visi Misi & Tentang Aplikasi | `screenshots/15_tentang_anpundung.png` |
| 16 | Penanganan Rute Tak Dikenal (`onUnknownRoute` 404) | `screenshots/16_rute_tidak_dikenal_404.png` |
| 17 | Tampilan Layar Lebar Adaptif (`NavigationRail`) | `screenshots/17_layar_lebar_navigation_rail.png` |

---

## 🧪 Pengujian & Verifikasi Kualitas Kode

Proyek ini telah melalui verifikasi menyeluruh tanpa peringatan (*Zero Warnings/Lints*) serta lulus seluruh pengujian otomatis:

```bash
# Analisis statis kode (Zero Warnings)
flutter analyze
# Output: No issues found!

# Pengujian unit dan antarmuka
flutter test
# Output: All tests passed!
```

---

## 🛠️ Cara Menjalankan Proyek

1. **Clone repositori:**
   ```bash
   git clone https://github.com/ghazyAlghifari508/tubes_anpundung_707012400023.git
   cd tubes_anpundung_707012400023
   ```
2. **Unduh dependensi Flutter:**
   ```bash
   flutter pub get
   ```
3. **Jalankan pada perangkat / emulator:**
   ```bash
   flutter run
   ```
