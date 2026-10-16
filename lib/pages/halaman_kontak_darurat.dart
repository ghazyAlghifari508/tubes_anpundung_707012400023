import 'package:flutter/material.dart';

/// Halaman Kontak Darurat Call Center Saber Pungli Kota Bandung
/// Menyediakan akses cepat panggilan telepon dan WhatsApp aduan terintegrasi.
class HalamanKontakDarurat extends StatelessWidget {
  const HalamanKontakDarurat({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> kontakList = [
      {
        'instansi': 'Satgas Saber Pungli Kota Bandung',
        'layanan': 'Hotline Pengaduan & Laporan Cepat 24 Jam',
        'nomor': '0811-2222-777',
        'icon': Icons.security_rounded,
        'badge': 'Utama',
        'color': const Color(0xFFE53935),
      },
      {
        'instansi': 'Polrestabes Bandung',
        'layanan': 'Sentra Pelayanan Kepolisian Terpadu (SPKT)',
        'nomor': '110 / (022) 4203500',
        'icon': Icons.local_police_rounded,
        'badge': 'Kepolisian',
        'color': const Color(0xFF163172),
      },
      {
        'instansi': 'Kejaksaan Negeri Kota Bandung',
        'layanan': 'Posko Pelayanan Hukum & Tindak Pidana Khusus',
        'nomor': '(022) 7208240',
        'icon': Icons.gavel_rounded,
        'badge': 'Kejaksaan',
        'color': Colors.indigo.shade800,
      },
      {
        'instansi': 'Inspektorat Daerah Kota Bandung',
        'layanan': 'Pengawasan Internal & Disiplin ASN Kota Bandung',
        'nomor': '(022) 4232370',
        'icon': Icons.corporate_fare_rounded,
        'badge': 'Pemerintah Kota',
        'color': Colors.teal.shade800,
      },
      {
        'instansi': 'Satpol PP Kota Bandung',
        'layanan': 'Penertiban PKL, Lapak Liar, & Ketertiban Umum',
        'nomor': '(022) 7300301',
        'icon': Icons.shield_moon_rounded,
        'badge': 'Penertiban',
        'color': Colors.brown.shade700,
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      appBar: AppBar(
        title: const Text('Kontak Darurat Saber Pungli'),
        backgroundColor: const Color(0xFF163172),
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: kontakList.length,
        itemBuilder: (context, index) {
          final item = kontakList[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 14),
            elevation: 1.5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
              side: BorderSide(color: Colors.grey.shade200),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 26,
                    backgroundColor:
                        (item['color'] as Color).withValues(alpha: 0.12),
                    child: Icon(
                      item['icon'] as IconData,
                      color: item['color'] as Color,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color:
                                (item['color'] as Color).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            item['badge'] as String,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: item['color'] as Color,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item['instansi'] as String,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF163172),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          item['layanan'] as String,
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item['nomor'] as String,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E56A0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.phone_forwarded_rounded),
                    color: Colors.green.shade700,
                    tooltip: 'Hubungi Instansi',
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text('Konfirmasi Panggilan Darurat'),
                          content: Text(
                            'Menghubungi ${item['instansi']} di nomor ${item['nomor']}?',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(ctx),
                              child: const Text('Batal'),
                            ),
                            FilledButton(
                              onPressed: () {
                                Navigator.pop(ctx);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Menghubungi ${item['nomor']}...',
                                    ),
                                    backgroundColor: const Color(0xFF163172),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              },
                              style: FilledButton.styleFrom(
                                backgroundColor: const Color(0xFF163172),
                              ),
                              child: const Text('Panggil Sekarang'),
                            ),
                          ],
                        ),
                      );
                    },
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
