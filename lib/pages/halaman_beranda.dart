import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/laporan_cubit.dart';
import '../navigation/app_routes.dart';

/// Halaman Beranda Anpundung (Anti Pungli Bandung)
/// Menampilkan statistik penindakan pungli, identitas pelapor,
/// aksi cepat, dan laporan terkini dari masyarakat.
class HalamanBeranda extends StatelessWidget {
  const HalamanBeranda({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Banner Sambutan & Header Warga
          _buildHeaderBanner(context),
          const SizedBox(height: 16),

          // Statistik Penindakan Saber Pungli Bandung
          _buildStatistikSection(),
          const SizedBox(height: 20),

          // Tombol Aksi Cepat
          const Text(
            'Layanan Aksi Cepat',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF163172),
            ),
          ),
          const SizedBox(height: 12),
          _buildAksiCepatGrid(context),
          const SizedBox(height: 20),

          // Banner Edukasi & Pengumuman Saber Pungli
          _buildBannerEdukasi(),
          const SizedBox(height: 20),

          // Laporan Terhangat yang Sedang Diproses
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Text(
                  'Laporan Warga Terkini',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF163172),
                  ),
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.riwayatLaporan);
                },
                icon: const Icon(Icons.arrow_forward_rounded, size: 16),
                label: const Text('Semua'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _buildDaftarLaporanTerkini(context),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildHeaderBanner(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF163172), Color(0xFF1E56A0)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF163172).withValues(alpha: 0.25),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.shield_rounded,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              const SizedBox(width: 14),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sampurasun, Warga Bandung!',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Satgas Saber Pungli Kota Bandung',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFFD6E4E5),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Divider(color: Colors.white24, height: 24),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Row(
              children: [
                Icon(Icons.badge_rounded, color: Colors.amber, size: 20),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Pelapor: Ghazy Nabil Alghfari (707012400023 | D4SIKC)',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
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

  Widget _buildStatistikSection() {
    return BlocBuilder<LaporanCubit, LaporanState>(
      builder: (context, state) {
        return Row(
          children: [
            _buildStatCard(
              title: 'Total Laporan',
              count: state.totalLaporan.toString(),
              icon: Icons.assignment_rounded,
              color: const Color(0xFF1E56A0),
            ),
            const SizedBox(width: 10),
            _buildStatCard(
              title: 'Investigasi',
              count: state.totalInvestigasi.toString(),
              icon: Icons.hourglass_top_rounded,
              color: Colors.orange.shade800,
            ),
            const SizedBox(width: 10),
            _buildStatCard(
              title: 'Ditindak Tegas',
              count: state.totalDitindak.toString(),
              icon: Icons.verified_rounded,
              color: Colors.green.shade700,
            ),
          ],
        );
      },
    );
  }

  Widget _buildStatCard({
    required String title,
    required String count,
    required IconData icon,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 6),
            Text(
              count,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              title,
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

  Widget _buildAksiCepatGrid(BuildContext context) {
    return Row(
      children: [
        _buildAksiButton(
          context: context,
          icon: Icons.add_circle_outline_rounded,
          label: 'Lapor Pungli',
          color: const Color(0xFFE53935),
          onTap: () async {
            final result = await Navigator.pushNamed(context, AppRoutes.buatLaporan);
            if (result != null && context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(result.toString()),
                  backgroundColor: const Color(0xFF163172),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          },
        ),
        const SizedBox(width: 10),
        _buildAksiButton(
          context: context,
          icon: Icons.location_on_rounded,
          label: 'Titik Rawan',
          color: const Color(0xFF1E56A0),
          onTap: () => Navigator.pushNamed(context, AppRoutes.titikRawan),
        ),
        const SizedBox(width: 10),
        _buildAksiButton(
          context: context,
          icon: Icons.phone_in_talk_rounded,
          label: 'Call Center',
          color: Colors.teal.shade700,
          onTap: () => Navigator.pushNamed(context, AppRoutes.kontakDarurat),
        ),
        const SizedBox(width: 10),
        _buildAksiButton(
          context: context,
          icon: Icons.gavel_rounded,
          label: 'Dasar Hukum',
          color: Colors.indigo.shade700,
          onTap: () => Navigator.pushNamed(context, AppRoutes.panduanHukum),
        ),
      ],
    );
  }

  Widget _buildAksiButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withValues(alpha: 0.2)),
          ),
          child: Column(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: color,
                child: Icon(icon, color: Colors.white, size: 20),
              ),
              const SizedBox(height: 8),
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Colors.blueGrey.shade800,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBannerEdukasi() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8E1),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFFFE082)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.warning_amber_rounded,
            color: Color(0xFFF57F17),
            size: 28,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Kawal Perwal Parkir Kota Bandung!',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFE65100),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Tarif parkir resmi zona pusat kota: Motor Rp 2.000, Mobil Rp 5.000. Jukir wajib memberi karcis resmi. Laporkan oknum yang memaksa tarif liar!',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.brown.shade800,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDaftarLaporanTerkini(BuildContext context) {
    return BlocBuilder<LaporanCubit, LaporanState>(
      builder: (context, state) {
        final laporanList = state.daftarLaporan.take(3).toList();

        if (laporanList.isEmpty) {
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: const Center(
              child: Text(
                'Belum ada laporan pengaduan.',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          );
        }

        return Column(
          children: laporanList.map((item) {
            final args = RincianLaporanArguments(
              idLaporan: item.id,
              judul: item.judul,
              kategori: item.kategori,
              lokasi: item.lokasi,
              terlapor: item.terlapor,
              nominal: item.nominal,
              tanggal: item.tanggal,
              status: item.status == 'Investigasi'
                  ? 'Sedang Diinvestigasi Satgas'
                  : item.status == 'Verifikasi'
                      ? 'Tahap Verifikasi Bukti'
                      : 'Selesai Ditindak Tegas',
              deskripsi: item.deskripsi,
              tindakLanjut: item.tindakLanjut,
            );

            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.grey.shade200),
              ),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color:
                                const Color(0xFF1E56A0).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            item.kategori,
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1E56A0),
                            ),
                          ),
                        ),
                        Text(
                          item.tanggal,
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item.judul,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF163172),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 14,
                          color: Colors.grey.shade600,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            item.lokasi,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade700,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              const Icon(
                                Icons.monetization_on_outlined,
                                size: 16,
                                color: Color(0xFFE53935),
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  item.nominal,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFE53935),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        FilledButton.tonal(
                          onPressed: () async {
                            final result = await Navigator.pushNamed(
                              context,
                              AppRoutes.rincianLaporan,
                              arguments: args,
                            );
                            if (result != null && context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(result.toString()),
                                  backgroundColor: const Color(0xFF163172),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            }
                          },
                          style: FilledButton.styleFrom(
                            visualDensity: VisualDensity.compact,
                          ),
                          child: const Text('Rincian & Aksi'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
