import 'package:flutter/material.dart';
import '../navigation/app_routes.dart';

/// Halaman Rincian Laporan Pungli
/// Menerima parameter dinamis RincianLaporanArguments melalui Named Route (/rincian-laporan)
/// dan mengembalikan hasil (result) ke halaman pemanggil untuk memicu SnackBar.
class HalamanRincianLaporan extends StatelessWidget {
  final RincianLaporanArguments arguments;

  const HalamanRincianLaporan({
    super.key,
    required this.arguments,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      appBar: AppBar(
        title: const Text('Rincian Aduan Pungli'),
        backgroundColor: const Color(0xFF163172),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Kartu Status
            _buildStatusCard(),
            const SizedBox(height: 16),

            // Informasi Pokok Laporan
            _buildInfoCard(),
            const SizedBox(height: 16),

            // Deskripsi & Kronologi Kasus
            _buildKronologiCard(),
            const SizedBox(height: 16),

            // Catatan Penindakan Saber Pungli
            _buildTindakLanjutCard(),
            const SizedBox(height: 24),

            // Tombol Interaksi & Pengembalian Data (Pop with Result)
            SizedBox(
              width: double.infinity,
              height: 52,
              child: FilledButton.icon(
                onPressed: () {
                  final pesanBalik =
                      'Aduan "${arguments.judul}" berhasil didukung dan diprioritaskan oleh Satgas Saber Pungli!';
                  Navigator.pop(context, pesanBalik);
                },
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFF163172),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                icon: const Icon(Icons.verified_user_rounded),
                label: const Text(
                  'Dukung & Tindak Lanjuti Aduan Ini',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF163172),
                  side: const BorderSide(color: Color(0xFF163172)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                icon: const Icon(Icons.arrow_back_rounded),
                label: const Text('Kembali ke Daftar'),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: const Color(0xFF163172).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  arguments.idLaporan,
                  style: const TextStyle(
                    fontSize: 12,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF163172),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: const Color(0xFFE53935).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  arguments.status,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFE53935),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            arguments.judul,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF163172),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Kategori: ${arguments.kategori} | Dilaporkan pada: ${arguments.tanggal}',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Informasi Kejadian',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Color(0xFF163172),
            ),
          ),
          const Divider(height: 20),
          _buildRowInfo(
            icon: Icons.location_on_rounded,
            label: 'Lokasi Kejadian',
            value: arguments.lokasi,
          ),
          const SizedBox(height: 12),
          _buildRowInfo(
            icon: Icons.person_off_rounded,
            label: 'Pihak Terlapor',
            value: arguments.terlapor,
          ),
          const SizedBox(height: 12),
          _buildRowInfo(
            icon: Icons.payments_rounded,
            label: 'Nominal Pungli Diminta',
            value: arguments.nominal,
            valueColor: const Color(0xFFE53935),
            isBold: true,
          ),
        ],
      ),
    );
  }

  Widget _buildRowInfo({
    required IconData icon,
    required String label,
    required String value,
    Color? valueColor,
    bool isBold = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: const Color(0xFF1E56A0)),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
                  color: valueColor ?? Colors.blueGrey.shade900,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildKronologiCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
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
              Icon(Icons.notes_rounded, color: Color(0xFF163172), size: 20),
              SizedBox(width: 8),
              Text(
                'Kronologi & Kesaksian Pelapor',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF163172),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            arguments.deskripsi,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade800,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTindakLanjutCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFA5D6A7)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.gavel_rounded,
                color: Colors.green.shade800,
                size: 22,
              ),
              const SizedBox(width: 8),
              Text(
                'Tindakan Satgas Saber Pungli',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            arguments.tindakLanjut,
            style: TextStyle(
              fontSize: 13,
              color: Colors.green.shade900,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}
