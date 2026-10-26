import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/bookmark_cubit.dart';

/// Halaman Titik Rawan Pungli di Kota Bandung
/// Menampilkan peta zona rawan dan titik kewaspadaan warga terhadap oknum pungli.
/// Dilengkapi fitur bookmark / pantau lokasi berbasis BookmarkTitikRawanCubit.
class HalamanTitikRawan extends StatelessWidget {
  const HalamanTitikRawan({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> titikRawanList = [
      {
        'id': 'TR-BDG-01',
        'nama': 'Kawasan Wisata Asia Afrika & Alun-Alun',
        'kategori': 'Zona Merah Parkir Liar',
        'modus':
            'Getok tarif parkir motor Rp 10.000, mobil Rp 25.000 tanpa karcis resmi.',
        'posko': 'Pos Pengamanan Gabungan Alun-Alun Bandung',
        'statusPatroli': 'Patroli Intensif 24 Jam',
        'color': Colors.red.shade700,
      },
      {
        'id': 'TR-BDG-02',
        'nama': 'Sepanjang Jalan Tamansari (Depan Kampus ITB & Baksil)',
        'kategori': 'Zona Kuning Parkir Trotoar',
        'modus':
            'Penggunaan trotoar pejalan kaki menjadi lapak parkir liar komersial.',
        'posko': 'Posko Satpol PP Coblong',
        'statusPatroli': 'Operasi Penertiban Pagi & Sore',
        'color': Colors.amber.shade800,
      },
      {
        'id': 'TR-BDG-03',
        'nama': 'Pasar Baru Trade Center (Jl. Otto Iskandardinata)',
        'kategori': 'Zona Merah Retribusi Siluman',
        'modus':
            'Pungutan bongkar muat dan sewa lapak jalanan oleh oknum ormas.',
        'posko': 'Posko Saber Pungli Pasar Baru',
        'statusPatroli': 'Pengawasan CCTV Terpadu',
        'color': Colors.red.shade700,
      },
      {
        'id': 'TR-BDG-04',
        'nama': 'Kawasan Sentra Rajut & PKL Binong Jati',
        'kategori': 'Zona Kuning Retribusi Izin Usaha',
        'modus':
            'Iuran kebersihan dan koordinasi fiktif di luar retribusi resmi DLH.',
        'posko': 'Kantor Polsek Batununggal',
        'statusPatroli': 'Monitoring Berkala Babinkamtibmas',
        'color': Colors.amber.shade800,
      },
      {
        'id': 'TR-BDG-05',
        'nama': 'Terminal Cicaheum & Stasiun Kiaracondong',
        'kategori': 'Zona Merah Calo & Parkir Liar',
        'modus':
            'Pemaksaan jasa angkut porter berlebih dan tiket tidak resmi.',
        'posko': 'Posko Terpadu Dishub & Saber Pungli',
        'statusPatroli': 'Patroli Sabhara & Dishub',
        'color': Colors.red.shade700,
      },
    ];

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? null : const Color(0xFFF8F9FE),
      appBar: AppBar(
        title: const Text('Titik Rawan Pungli Bandung'),
        backgroundColor: isDark ? null : const Color(0xFF163172),
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: titikRawanList.length,
        itemBuilder: (context, index) {
          final item = titikRawanList[index];
          final idLokasi = item['id'] as String;

          return Card(
            margin: const EdgeInsets.only(bottom: 14),
            elevation: 1.5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
              side: BorderSide(color: isDark ? Colors.white12 : Colors.grey.shade200),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color:
                              (item['color'] as Color).withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          item['kategori'] as String,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: item['color'] as Color,
                          ),
                        ),
                      ),
                      BlocSelector<BookmarkTitikRawanCubit, Set<String>, bool>(
                        selector: (state) => state.contains(idLokasi),
                        builder: (context, isBookmarked) {
                          return IconButton(
                            icon: Icon(
                              isBookmarked
                                  ? Icons.bookmark_rounded
                                  : Icons.bookmark_border_rounded,
                              color: isBookmarked
                                  ? Colors.amber.shade800
                                  : Colors.grey,
                            ),
                            tooltip: isBookmarked
                                ? 'Batal Pantau Titik Ini'
                                : 'Pantau Titik Rawan Ini',
                            onPressed: () {
                              context
                                  .read<BookmarkTitikRawanCubit>()
                                  .toggleBookmark(idLokasi);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    isBookmarked
                                        ? 'Lokasi "${item['nama']}" dihapus dari daftar pantauan.'
                                        : 'Lokasi "${item['nama']}" ditambahkan ke daftar pantauan warga!',
                                  ),
                                  backgroundColor: const Color(0xFF163172),
                                  behavior: SnackBarBehavior.floating,
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    item['nama'] as String,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isDark ? const Color(0xFF90CAF9) : const Color(0xFF163172),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    item['modus'] as String,
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? Colors.grey.shade300 : Colors.grey.shade800,
                      height: 1.4,
                    ),
                  ),
                  const Divider(height: 20),
                  Row(
                    children: [
                      const Icon(
                        Icons.local_police_outlined,
                        size: 16,
                        color: Color(0xFF1E56A0),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          '${item['posko']} • ${item['statusPatroli']}',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
