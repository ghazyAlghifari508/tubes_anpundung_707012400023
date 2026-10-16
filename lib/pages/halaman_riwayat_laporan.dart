import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/laporan_cubit.dart';
import '../navigation/app_routes.dart';

/// Halaman Riwayat Laporan Pengaduan
/// Mengimplementasikan BottomAppBar dengan CircularNotchedRectangle
/// serta FloatingActionButton berposisi centerDocked untuk aksi pelaporan pungli kilat.
/// Terhubung dengan LaporanCubit untuk reaktivitas daftar laporan secara real-time.
class HalamanRiwayatLaporan extends StatelessWidget {
  const HalamanRiwayatLaporan({super.key});

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Investigasi':
        return Colors.orange.shade800;
      case 'Verifikasi':
        return Colors.blue.shade700;
      case 'Selesai':
        return Colors.green.shade700;
      default:
        return const Color(0xFF1E56A0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      appBar: AppBar(
        title: BlocBuilder<LaporanCubit, LaporanState>(
          builder: (context, state) {
            return Text('Riwayat Laporan (${state.totalLaporan})');
          },
        ),
        backgroundColor: const Color(0xFF163172),
        foregroundColor: Colors.white,
      ),
      body: BlocBuilder<LaporanCubit, LaporanState>(
        builder: (context, state) {
          final riwayat = state.daftarLaporan;

          if (riwayat.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.assignment_late_outlined,
                    size: 64,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Belum Ada Riwayat Laporan',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF163172),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Gunakan tombol "Lapor Kilat" di bawah untuk melaporkan pungli.',
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 90),
            itemCount: riwayat.length,
            itemBuilder: (context, index) {
              final item = riwayat[index];
              final statusColor = _getStatusColor(item.status);

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                  side: BorderSide(color: Colors.grey.shade200),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(14),
                  leading: CircleAvatar(
                    radius: 22,
                    backgroundColor: statusColor.withValues(alpha: 0.15),
                    child: Icon(
                      Icons.shield_outlined,
                      color: statusColor,
                      size: 24,
                    ),
                  ),
                  title: Text(
                    item.judul,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF163172),
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Text(
                        '${item.id} • ${item.lokasi}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              'Pungutan: ${item.nominal}',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFE53935),
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: statusColor.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              item.status,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: statusColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.delete_outline_rounded,
                      color: Colors.red.shade400,
                    ),
                    tooltip: 'Hapus Laporan',
                    onPressed: () {
                      final idDihapus = item.id;
                      final judulDihapus = item.judul;
                      context.read<LaporanCubit>().hapusLaporan(idDihapus);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Laporan "$judulDihapus" telah dihapus.'),
                          backgroundColor: const Color(0xFF163172),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                  ),
                  onTap: () {
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
                    Navigator.pushNamed(
                      context,
                      AppRoutes.rincianLaporan,
                      arguments: args,
                    );
                  },
                ),
              );
            },
          );
        },
      ),

      // Floating Action Button CenterDocked
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final result =
              await Navigator.pushNamed(context, AppRoutes.buatLaporan);
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
        backgroundColor: const Color(0xFFE53935),
        foregroundColor: Colors.white,
        elevation: 4,
        icon: const Icon(Icons.add_rounded),
        label: const Text('Lapor Kilat'),
      ),

      // BottomAppBar dengan CircularNotchedRectangle
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        color: const Color(0xFF163172),
        elevation: 8,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon:
                    const Icon(Icons.filter_list_rounded, color: Colors.white),
                tooltip: 'Saring Status Aduan',
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content:
                          Text('Filter status aduan diaktifkan (Semua Status)'),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.search_rounded, color: Colors.white),
                tooltip: 'Cari Riwayat',
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content:
                          Text('Pencarian riwayat laporan siap digunakan'),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
              ),
              const SizedBox(width: 48), // Ruang kosong untuk lekukan FAB
              IconButton(
                icon: const Icon(Icons.file_download_rounded,
                    color: Colors.white),
                tooltip: 'Unduh Bukti Tanda Terima',
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content:
                          Text('Bukti tanda terima aduan berhasil diunduh'),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.refresh_rounded, color: Colors.white),
                tooltip: 'Segarkan Riwayat',
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Data riwayat aduan telah disegarkan'),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
