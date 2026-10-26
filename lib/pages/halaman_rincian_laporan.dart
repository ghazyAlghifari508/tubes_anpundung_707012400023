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
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? null : const Color(0xFFF8F9FE),
      appBar: AppBar(
        title: const Text('Rincian Aduan Pungli'),
        backgroundColor: isDark ? null : const Color(0xFF163172),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Kartu Status
            _buildStatusCard(isDark),
            const SizedBox(height: 16),

            // Informasi Pokok Laporan
            _buildInfoCard(isDark),
            const SizedBox(height: 16),

            // Deskripsi & Kronologi Kasus
            _buildKronologiCard(isDark),
            const SizedBox(height: 16),

            // Catatan Penindakan Saber Pungli
            _buildTindakLanjutCard(isDark),
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
                  backgroundColor: isDark ? const Color(0xFF1E3A8A) : const Color(0xFF163172),
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
                  foregroundColor: isDark ? const Color(0xFF90CAF9) : const Color(0xFF163172),
                  side: BorderSide(color: isDark ? const Color(0xFF90CAF9) : const Color(0xFF163172)),
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

  Widget _buildStatusCard(bool isDark) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isDark ? Colors.white12 : Colors.grey.shade200),
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
                  color: isDark
                      ? const Color(0xFF1E3A8A).withValues(alpha: 0.3)
                      : const Color(0xFF163172).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  arguments.idLaporan,
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.bold,
                    color: isDark ? const Color(0xFF90CAF9) : const Color(0xFF163172),
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
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isDark ? const Color(0xFF90CAF9) : const Color(0xFF163172),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Kategori: ${arguments.kategori} | Dilaporkan pada: ${arguments.tanggal}',
            style: TextStyle(
              fontSize: 12,
              color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(bool isDark) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isDark ? Colors.white12 : Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Informasi Kejadian',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: isDark ? const Color(0xFF90CAF9) : const Color(0xFF163172),
            ),
          ),
          const Divider(height: 20),
          _buildRowInfo(
            icon: Icons.location_on_rounded,
            label: 'Lokasi Kejadian',
            value: arguments.lokasi,
            isDark: isDark,
          ),
          const SizedBox(height: 12),
          _buildRowInfo(
            icon: Icons.person_off_rounded,
            label: 'Pihak Terlapor',
            value: arguments.terlapor,
            isDark: isDark,
          ),
          const SizedBox(height: 12),
          _buildRowInfo(
            icon: Icons.payments_rounded,
            label: 'Nominal Pungli Diminta',
            value: arguments.nominal,
            valueColor: const Color(0xFFE53935),
            isBold: true,
            isDark: isDark,
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
    bool isDark = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: isDark ? const Color(0xFF64B5F6) : const Color(0xFF1E56A0)),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
                  color: valueColor ?? (isDark ? Colors.white : Colors.blueGrey.shade900),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildKronologiCard(bool isDark) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isDark ? Colors.white12 : Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.notes_rounded, color: isDark ? const Color(0xFF90CAF9) : const Color(0xFF163172), size: 20),
              const SizedBox(width: 8),
              Text(
                'Kronologi & Kesaksian Pelapor',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: isDark ? const Color(0xFF90CAF9) : const Color(0xFF163172),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            arguments.deskripsi,
            style: TextStyle(
              fontSize: 13,
              color: isDark ? Colors.grey.shade300 : Colors.grey.shade800,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTindakLanjutCard(bool isDark) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF0F3820) : const Color(0xFFE8F5E9),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isDark ? const Color(0xFF2E7D32) : const Color(0xFFA5D6A7)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.gavel_rounded,
                color: isDark ? Colors.green.shade300 : Colors.green.shade800,
                size: 22,
              ),
              const SizedBox(width: 8),
              Text(
                'Tindakan Satgas Saber Pungli',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.green.shade200 : Colors.green.shade900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            arguments.tindakLanjut,
            style: TextStyle(
              fontSize: 13,
              color: isDark ? Colors.green.shade100 : Colors.green.shade900,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}
