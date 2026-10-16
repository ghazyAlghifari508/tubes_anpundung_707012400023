import 'package:flutter/material.dart';

/// Halaman Tentang Aplikasi Anpundung (Anti Pungli Bandung)
/// Menyajikan informasi visi, misi, fitur pengawasan publik, dan pengembang sistem.
class HalamanTentangAplikasi extends StatelessWidget {
  const HalamanTentangAplikasi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      appBar: AppBar(
        title: const Text('Tentang Anpundung'),
        backgroundColor: const Color(0xFF163172),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            // Logo Aplikasi
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF163172).withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.shield_rounded,
                size: 64,
                color: Color(0xFF163172),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Anpundung Mobile',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF163172),
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Anti Pungli Bandung • Versi 2.0.0 (Smart Governance)',
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 24),

            // Deskripsi Resmi Aplikasi
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade200),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(
                        Icons.info_outline_rounded,
                        color: Color(0xFF163172),
                        size: 22,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Visi & Misi Sistem',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF163172),
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 20),
                  Text(
                    'Anpundung Mobile adalah platform partisipasi publik terpadu warga Kota Bandung untuk memantau, mendokumentasikan, dan melaporkan segala bentuk praktik pungutan liar, pemerasan, dan pelanggaran tarif layanan publik secara cepat, aman, dan terpercaya.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade800,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildPoinFitur(
                    Icons.security_rounded,
                    'Kerahasiaan data pelapor (Whistleblower Protection) terjamin.',
                  ),
                  _buildPoinFitur(
                    Icons.speed_rounded,
                    'Integrasi pelaporan langsung dengan Satgas Saber Pungli.',
                  ),
                  _buildPoinFitur(
                    Icons.track_changes_rounded,
                    'Pelacakan status penindakan aduan secara transparan.',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),

            // Kartu Profil Pengembang
            Card(
              elevation: 1.5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: Colors.grey.shade200),
              ),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.person_pin_rounded,
                          color: Color(0xFF163172),
                          size: 22,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Informasi Pengembang',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF163172),
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 20),
                    _buildItemProfil('Pengembang', 'Ghazy Nabil Alghfari'),
                    _buildItemProfil('ID Kontributor', '707012400023'),
                    _buildItemProfil('Institusi', 'Universitas Telkom Bandung'),
                    _buildItemProfil('Bidang', 'Sistem Informasi Kota Cerdas'),
                    _buildItemProfil('Repositori', 'github.com/ghazyAlghifari508'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 18),

            // Informasi Layanan Satgas
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F0FE),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFB8D3FE)),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.verified_user_rounded,
                    color: Color(0xFF163172),
                    size: 28,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Saber Pungli Kota Bandung',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF163172),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Bersama kita wujudkan Kota Bandung yang bersih, nyaman, dan bebas pungli.',
                          style: TextStyle(
                            fontSize: 11.5,
                            color: Colors.blueGrey.shade800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildPoinFitur(IconData icon, String teks) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: const Color(0xFF1E56A0)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              teks,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemProfil(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12.5,
                color: Colors.grey.shade600,
              ),
            ),
          ),
          const Text(': ', style: TextStyle(fontSize: 12.5)),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.bold,
                color: Color(0xFF163172),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
