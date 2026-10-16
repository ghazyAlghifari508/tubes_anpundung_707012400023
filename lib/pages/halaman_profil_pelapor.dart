import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/bookmark_cubit.dart';
import '../cubit/laporan_cubit.dart';
import '../navigation/app_routes.dart';

/// Halaman Profil Pelapor Warga
/// Menampilkan identitas mahasiswa, status verifikasi pelapor,
/// lencana integritas anti-pungli, statistik aduan reaktif, dan titik pantauan warga.
class HalamanProfilPelapor extends StatelessWidget {
  const HalamanProfilPelapor({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Kartu Identitas Resmi Mahasiswa / Pelapor
          _buildIdentityCard(),
          const SizedBox(height: 18),

          // Lencana Keberanian & Integritas
          _buildBadgesSection(),
          const SizedBox(height: 18),

          // Statistik Aduan Pelapor (Reaktif dari LaporanCubit)
          _buildStatistikPelapor(),
          const SizedBox(height: 20),

          // Titik Rawan Dipantau Warga (Reaktif dari BookmarkTitikRawanCubit)
          _buildTitikRawanDipantau(context),
          const SizedBox(height: 20),

          // Tombol Buka Riwayat Laporan (dengan BottomAppBar)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(
                      Icons.history_edu_rounded,
                      color: Color(0xFF163172),
                      size: 22,
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Pusat Riwayat & Pantauan Aduan',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF163172),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  'Buka halaman riwayat lengkap untuk memantau status tindak lanjut, surat tanda bukti lapor, dan tombol aksi BottomAppBar.',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: FilledButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.riwayatLaporan);
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFF163172),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: const Icon(Icons.open_in_new_rounded, size: 18),
                    label: const Text('Buka Riwayat Laporan Lengkap'),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildIdentityCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF163172), Color(0xFF0F4C81)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF163172).withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 34,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 31,
                  backgroundColor: const Color(0xFF163172),
                  child: const Icon(
                    Icons.person_rounded,
                    size: 38,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ghazy Nabil Alghfari',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'NIM: 707012400023',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFFD6E4E5),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'D4 SIKC (48-03) | FIT Telkom Univ',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Divider(color: Colors.white24, height: 26),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Row(
              children: [
                Icon(Icons.verified_rounded, color: Colors.amber, size: 20),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'STATUS: PELAPOR RESMI TERVERIFIKASI SABER PUNGLI',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.3,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadgesSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Lencana Integritas Warga',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Color(0xFF163172),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildBadgeItem(
                icon: Icons.shield_rounded,
                title: 'Pelindung Kota',
                desc: 'Level Emas',
                color: Colors.amber.shade800,
              ),
              const SizedBox(width: 8),
              _buildBadgeItem(
                icon: Icons.check_circle_rounded,
                title: 'Aduan Valid',
                desc: '100% Akurat',
                color: Colors.green.shade700,
              ),
              const SizedBox(width: 8),
              _buildBadgeItem(
                icon: Icons.thumb_up_alt_rounded,
                title: 'Duta Transparan',
                desc: 'Aktif 2026',
                color: const Color(0xFF1E56A0),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBadgeItem({
    required IconData icon,
    required String title,
    required String desc,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.2)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 6),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              desc,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatistikPelapor() {
    return BlocBuilder<LaporanCubit, LaporanState>(
      builder: (context, state) {
        return Row(
          children: [
            _buildStatBox(
              state.totalLaporan.toString(),
              'Laporan Dikirim',
              const Color(0xFF163172),
            ),
            const SizedBox(width: 10),
            _buildStatBox(
              (state.totalInvestigasi + state.totalVerifikasi).toString(),
              'Diproses Satgas',
              Colors.orange.shade800,
            ),
            const SizedBox(width: 10),
            _buildStatBox(
              state.totalDitindak.toString(),
              'Tuntas Selesai',
              Colors.green.shade700,
            ),
          ],
        );
      },
    );
  }

  Widget _buildStatBox(String count, String label, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          children: [
            Text(
              count,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitikRawanDipantau(BuildContext context) {
    final Map<String, String> masterLokasi = {
      'TR-BDG-01': 'Kawasan Wisata Asia Afrika & Alun-Alun',
      'TR-BDG-02': 'Sepanjang Jalan Tamansari (ITB & Baksil)',
      'TR-BDG-03': 'Pasar Baru Trade Center (Jl. Otto Iskandardinata)',
      'TR-BDG-04': 'Kawasan Sentra Rajut & PKL Binong Jati',
      'TR-BDG-05': 'Terminal Cicaheum & Stasiun Kiaracondong',
    };

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Row(
                  children: [
                    Icon(
                      Icons.bookmark_added_rounded,
                      color: Color(0xFF163172),
                      size: 20,
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Titik Rawan Dipantau',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF163172),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.titikRawan);
                },
                child: const Text('Kelola'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          BlocBuilder<BookmarkTitikRawanCubit, Set<String>>(
            builder: (context, dipantau) {
              if (dipantau.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    'Belum ada titik rawan yang dipantau. Tambahkan bookmark dari menu Titik Rawan.',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                );
              }

              return Column(
                children: dipantau.map((id) {
                  final nama = masterLokasi[id] ?? id;
                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8F9FE),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.location_on_rounded,
                          size: 18,
                          color: Color(0xFFE53935),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            nama,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF163172),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close_rounded, size: 18),
                          tooltip: 'Hapus Pantauan',
                          onPressed: () {
                            context
                                .read<BookmarkTitikRawanCubit>()
                                .batalPantau(id);
                          },
                        ),
                      ],
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}
