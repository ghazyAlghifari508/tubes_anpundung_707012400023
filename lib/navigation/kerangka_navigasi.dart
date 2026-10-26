import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/laporan_cubit.dart';
import '../cubit/theme_cubit.dart';
import '../pages/halaman_beranda.dart';
import '../pages/halaman_kategori_pungli.dart';
import '../pages/halaman_profil_pelapor.dart';
import 'app_routes.dart';

/// Kerangka Navigasi Utama Anpundung (Anti Pungli Bandung)
/// Mengimplementasikan:
/// 1. PopScope (Perlindungan tombol back)
/// 2. NavigationBar Material 3 (Tampilan ponsel < 600px)
/// 3. NavigationRail (Tampilan tablet / lanskap >= 600px)
/// 4. NavigationDrawer dengan UserAccountsDrawerHeader
/// 5. ThemeCubit (Theming Material 3 & Mode Gelap)
class KerangkaNavigasiAnpundung extends StatefulWidget {
  const KerangkaNavigasiAnpundung({super.key});

  @override
  State<KerangkaNavigasiAnpundung> createState() =>
      _KerangkaNavigasiAnpundungState();
}

class _KerangkaNavigasiAnpundungState extends State<KerangkaNavigasiAnpundung> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HalamanBeranda(),
    HalamanKategoriPungli(),
    HalamanProfilPelapor(),
  ];

  final List<String> _titles = const [
    'Anpundung Mobile',
    'Kategori Modus Pungli',
    'Profil & Aduan Warga',
  ];

  void _onDestinationSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Future<bool> _handlePopScope() async {
    // Jika tidak berada di Beranda (index 0), kembalikan ke Beranda terlebih dahulu
    if (_currentIndex != 0) {
      setState(() {
        _currentIndex = 0;
      });
      return false; // Jangan tutup aplikasi
    }

    // Jika sudah di Beranda, tampilkan dialog konfirmasi keluar aplikasi
    final shouldPop = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Keluar dari Anpundung?'),
        content: const Text(
          'Apakah Anda yakin ingin keluar dari aplikasi pelaporan Anti Pungli Bandung?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFFE53935),
            ),
            child: const Text('Keluar'),
          ),
        ],
      ),
    );

    return shouldPop ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWideScreen = screenWidth >= 600;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        final shouldExit = await _handlePopScope();
        if (shouldExit && context.mounted) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            _titles[_currentIndex],
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          elevation: 1,
          actions: [
            BlocBuilder<ThemeCubit, ThemeMode>(
              builder: (context, themeMode) {
                final isDarkModeActive = themeMode == ThemeMode.dark;
                return IconButton(
                  icon: Icon(
                    isDarkModeActive
                        ? Icons.light_mode_rounded
                        : Icons.dark_mode_rounded,
                  ),
                  tooltip: isDarkModeActive
                      ? 'Ganti ke Mode Terang'
                      : 'Ganti ke Mode Gelap',
                  onPressed: () => context.read<ThemeCubit>().toggle(),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.add_alert_rounded),
              tooltip: 'Lapor Pungli Cepat',
              onPressed: () async {
                final result = await Navigator.pushNamed(
                  context,
                  AppRoutes.buatLaporan,
                );
                if (result != null && context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(result.toString()),
                      backgroundColor: isDark
                          ? const Color(0xFF1E3A8A)
                          : const Color(0xFF163172),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              },
            ),
          ],
        ),

        // NavigationDrawer
        drawer: _buildNavigationDrawer(context, isDark),

        // Body Adaptif
        body: isWideScreen
            ? Row(
                children: [
                  NavigationRail(
                    selectedIndex: _currentIndex,
                    onDestinationSelected: _onDestinationSelected,
                    labelType: NavigationRailLabelType.all,
                    leading: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: CircleAvatar(
                        backgroundColor: isDark
                            ? const Color(0xFF1E3A8A)
                            : const Color(0xFF163172),
                        child: const Icon(Icons.shield_rounded, color: Colors.white),
                      ),
                    ),
                    destinations: [
                      const NavigationRailDestination(
                        icon: Icon(Icons.dashboard_outlined),
                        selectedIcon: Icon(Icons.dashboard_rounded),
                        label: Text('Beranda'),
                      ),
                      const NavigationRailDestination(
                        icon: Icon(Icons.report_problem_outlined),
                        selectedIcon: Icon(Icons.report_problem_rounded),
                        label: Text('Kategori'),
                      ),
                      NavigationRailDestination(
                        icon: BlocSelector<LaporanCubit, LaporanState, int>(
                          selector: (state) => state.totalLaporan,
                          builder: (context, total) {
                            return Badge(
                              isLabelVisible: total > 0,
                              label: Text(total.toString()),
                              backgroundColor: const Color(0xFFE53935),
                              child: const Icon(Icons.person_outline_rounded),
                            );
                          },
                        ),
                        selectedIcon:
                            BlocSelector<LaporanCubit, LaporanState, int>(
                          selector: (state) => state.totalLaporan,
                          builder: (context, total) {
                            return Badge(
                              isLabelVisible: total > 0,
                              label: Text(total.toString()),
                              backgroundColor: const Color(0xFFE53935),
                              child: const Icon(Icons.person_rounded),
                            );
                          },
                        ),
                        label: const Text('Profil'),
                      ),
                    ],
                  ),
                  const VerticalDivider(thickness: 1, width: 1),
                  Expanded(child: _pages[_currentIndex]),
                ],
              )
            : _pages[_currentIndex],

        // Bottom NavigationBar (hanya pada layar < 600px)
        bottomNavigationBar: isWideScreen
            ? null
            : NavigationBar(
                selectedIndex: _currentIndex,
                onDestinationSelected: _onDestinationSelected,
                destinations: [
                  NavigationDestination(
                    icon: const Icon(Icons.dashboard_outlined),
                    selectedIcon: Icon(
                      Icons.dashboard_rounded,
                      color: isDark ? const Color(0xFF93C5FD) : const Color(0xFF163172),
                    ),
                    label: 'Beranda',
                  ),
                  NavigationDestination(
                    icon: const Icon(Icons.report_problem_outlined),
                    selectedIcon: Icon(
                      Icons.report_problem_rounded,
                      color: isDark ? const Color(0xFF93C5FD) : const Color(0xFF163172),
                    ),
                    label: 'Kategori',
                  ),
                  NavigationDestination(
                    icon: BlocSelector<LaporanCubit, LaporanState, int>(
                      selector: (state) => state.totalLaporan,
                      builder: (context, total) {
                        return Badge(
                          isLabelVisible: total > 0,
                          label: Text(total.toString()),
                          backgroundColor: const Color(0xFFE53935),
                          child: const Icon(Icons.person_outline_rounded),
                        );
                      },
                    ),
                    selectedIcon:
                        BlocSelector<LaporanCubit, LaporanState, int>(
                      selector: (state) => state.totalLaporan,
                      builder: (context, total) {
                        return Badge(
                          isLabelVisible: total > 0,
                          label: Text(total.toString()),
                          backgroundColor: const Color(0xFFE53935),
                          child: Icon(
                            Icons.person_rounded,
                            color: isDark ? const Color(0xFF93C5FD) : const Color(0xFF163172),
                          ),
                        );
                      },
                    ),
                    label: 'Profil',
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildNavigationDrawer(BuildContext context, bool isDark) {
    final theme = Theme.of(context);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Drawer Header Mahasiswa
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isDark
                    ? [const Color(0xFF1E293B), const Color(0xFF0F172A)]
                    : [const Color(0xFF163172), const Color(0xFF1E56A0)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: isDark ? const Color(0xFF0F172A) : Colors.white,
              child: Icon(
                Icons.shield_rounded,
                size: 42,
                color: isDark ? const Color(0xFF93C5FD) : const Color(0xFF163172),
              ),
            ),
            accountName: const Text(
              'Ghazy Nabil Alghfari',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            accountEmail: const Text(
              'NIM: 707012400023 | D4SIKC 48-03',
              style: TextStyle(color: Color(0xFFD6E4E5), fontSize: 13),
            ),
          ),

          // Grup Destinasi Utama
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: Text(
              'Layanan Utama',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.dashboard_rounded,
              color: isDark ? const Color(0xFF93C5FD) : const Color(0xFF163172),
            ),
            title: const Text('Beranda Anpundung'),
            selected: _currentIndex == 0,
            onTap: () {
              Navigator.pop(context);
              _onDestinationSelected(0);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.report_problem_rounded,
              color: isDark ? const Color(0xFF93C5FD) : const Color(0xFF163172),
            ),
            title: const Text('Kategori Pungli'),
            selected: _currentIndex == 1,
            onTap: () {
              Navigator.pop(context);
              _onDestinationSelected(1);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.person_rounded,
              color: isDark ? const Color(0xFF93C5FD) : const Color(0xFF163172),
            ),
            title: const Text('Profil & Laporan Saya'),
            trailing: BlocSelector<LaporanCubit, LaporanState, int>(
              selector: (state) => state.totalLaporan,
              builder: (context, total) {
                return Badge(
                  isLabelVisible: total > 0,
                  label: Text(total.toString()),
                  backgroundColor: const Color(0xFFE53935),
                );
              },
            ),
            selected: _currentIndex == 2,
            onTap: () {
              Navigator.pop(context);
              _onDestinationSelected(2);
            },
          ),

          const Divider(),

          // Grup Menu Pendukung
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: Text(
              'Menu Pendukung Saber Pungli',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.pin_drop_rounded, color: Color(0xFFE53935)),
            title: const Text('Titik Rawan Pungli'),
            onTap: () {
              Navigator.pop(context); // Tutup drawer sebelum navigasi
              Navigator.pushNamed(context, AppRoutes.titikRawan);
            },
          ),
          ListTile(
            leading: const Icon(Icons.gavel_rounded, color: Color(0xFFF57C00)),
            title: const Text('Panduan & Aspek Hukum'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, AppRoutes.panduanHukum);
            },
          ),
          ListTile(
            leading: const Icon(Icons.phone_in_talk_rounded, color: Color(0xFF388E3C)),
            title: const Text('Kontak Darurat Satgas'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, AppRoutes.kontakDarurat);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.info_outline_rounded,
              color: isDark ? const Color(0xFF93C5FD) : const Color(0xFF163172),
            ),
            title: const Text('Tentang Aplikasi'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, AppRoutes.tentangAplikasi);
            },
          ),

          const Divider(),

          ListTile(
            leading: const Icon(Icons.logout_rounded, color: Color(0xFFE53935)),
            title: const Text(
              'Keluar Aplikasi',
              style: TextStyle(color: Color(0xFFE53935), fontWeight: FontWeight.bold),
            ),
            onTap: () async {
              Navigator.pop(context);
              final shouldExit = await _handlePopScope();
              if (shouldExit && context.mounted) {
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
    );
  }
}
