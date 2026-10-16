import 'package:flutter/material.dart';

/// Halaman Panduan Hukum & Regulasi Anti-Pungli
/// Mengedukasi masyarakat tentang landasan hukum, sanksi pidana pungli, dan hak pelapor.
class HalamanPanduanHukum extends StatelessWidget {
  const HalamanPanduanHukum({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> regulasiList = [
      {
        'judul': 'Perpres Nomor 87 Tahun 2016',
        'subjudul': 'Satuan Tugas Sapu Bersih Pungutan Liar (Saber Pungli)',
        'isi':
            'Mengamanatkan pembentukan satgas terpadu di tingkat kementerian, lembaga, dan pemerintah daerah untuk memberantas praktik pungutan liar secara efektif, efisien, dan menimbulkan efek jera.',
        'sanksi': 'Pidana penjara dan pemecatan tidak dengan hormat bagi aparatur.',
      },
      {
        'judul': 'Pasal 368 KUHPidana',
        'subjudul': 'Tindak Pidana Pemerasan dengan Ancaman',
        'isi':
            'Barang siapa dengan maksud untuk menguntungkan diri sendiri atau orang lain secara melawan hukum, memaksa seorang dengan kekerasan atau ancaman kekerasan untuk memberikan barang sesuatu.',
        'sanksi': 'Diancam dengan pidana penjara paling lama 9 (sembilan) tahun.',
      },
      {
        'judul': 'Pasal 423 KUHPidana',
        'subjudul': 'Penyalahgunaan Wewenang Pegawai Negeri',
        'isi':
            'Pegawai negeri atau pejabat yang dengan maksud menguntungkan diri sendiri atau orang lain secara melawan hukum, dengan menyalahgunakan kekuasaannya memaksa seseorang memberikan sesuatu.',
        'sanksi': 'Diancam dengan pidana penjara paling lama 6 (enam) tahun.',
      },
      {
        'judul': 'Perlindungan Saksi & Pelapor (Whistleblower)',
        'subjudul': 'Undang-Undang Nomor 31 Tahun 2014 (LPSK)',
        'isi':
            'Pelapor tindak pidana korupsi dan pungutan liar berhak mendapatkan perlindungan hukum, kerahasiaan identitas pribadi, dan tidak dapat dituntut secara hukum baik pidana maupun perdata atas laporannya.',
        'sanksi': 'Kerahasiaan data dijamin 100% oleh Satgas dan LPSK.',
      },
      {
        'judul': 'Peraturan Walikota Bandung No. 66 Tahun 2021',
        'subjudul': 'Tarif Retribusi Pelayanan Parkir di Bahu Jalan',
        'isi':
            'Mengatur batas tarif parkir resmi Kota Bandung zona pusat: Motor Rp 2.000 / jam, Mobil Rp 5.000 / jam. Warga berhak menolak membayar bila jukir tidak menyerahkan karcis resmi berporporasi.',
        'sanksi': 'Penertiban jukir liar oleh Dishub dan Polrestabes Bandung.',
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      appBar: AppBar(
        title: const Text('Panduan Hukum Anti-Pungli'),
        backgroundColor: const Color(0xFF163172),
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: regulasiList.length,
        itemBuilder: (context, index) {
          final item = regulasiList[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 14),
            elevation: 1.5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
              side: BorderSide(color: Colors.grey.shade200),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF163172).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.menu_book_rounded,
                          color: Color(0xFF163172),
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['judul']!,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF163172),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              item['subjudul']!,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.blueGrey.shade700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    item['isi']!,
                    style: TextStyle(
                      fontSize: 12.5,
                      color: Colors.grey.shade800,
                      height: 1.45,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF3E0),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.gavel_rounded,
                          size: 16,
                          color: Color(0xFFE65100),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            'Sanksi / Jaminan: ${item['sanksi']!}',
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFE65100),
                            ),
                          ),
                        ),
                      ],
                    ),
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
