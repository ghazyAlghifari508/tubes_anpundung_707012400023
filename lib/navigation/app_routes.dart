import 'package:flutter/material.dart';
import '../navigation/kerangka_navigasi.dart';
import '../pages/halaman_buat_laporan.dart';
import '../pages/halaman_rincian_laporan.dart';
import '../pages/halaman_riwayat_laporan.dart';
import '../pages/halaman_titik_rawan.dart';
import '../pages/halaman_kontak_darurat.dart';
import '../pages/halaman_panduan_hukum.dart';
import '../pages/halaman_tentang_aplikasi.dart';

/// Model argumen untuk navigasi rute Halaman Rincian Laporan
class RincianLaporanArguments {
  final String idLaporan;
  final String judul;
  final String kategori;
  final String lokasi;
  final String terlapor;
  final String nominal;
  final String tanggal;
  final String status;
  final String deskripsi;
  final String tindakLanjut;

  const RincianLaporanArguments({
    required this.idLaporan,
    required this.judul,
    required this.kategori,
    required this.lokasi,
    required this.terlapor,
    required this.nominal,
    required this.tanggal,
    required this.status,
    required this.deskripsi,
    required this.tindakLanjut,
  });
}

/// Pengelola rute sentral aplikasi Anpundung (Anti Pungli Bandung)
class AppRoutes {
  static const String utama = '/';
  static const String buatLaporan = '/buat-laporan';
  static const String rincianLaporan = '/rincian-laporan';
  static const String riwayatLaporan = '/riwayat-laporan';
  static const String titikRawan = '/titik-rawan';
  static const String kontakDarurat = '/kontak-darurat';
  static const String panduanHukum = '/panduan-hukum';
  static const String tentangAplikasi = '/tentang-aplikasi';

  /// Generator rute dinamis untuk menangani pengiriman parameter/arguments
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case utama:
        return MaterialPageRoute(
          builder: (_) => const KerangkaNavigasiAnpundung(),
          settings: settings,
        );

      case buatLaporan:
        return MaterialPageRoute(
          builder: (_) => const HalamanBuatLaporan(),
          settings: settings,
        );

      case rincianLaporan:
        final args = settings.arguments;
        if (args is RincianLaporanArguments) {
          return MaterialPageRoute(
            builder: (_) => HalamanRincianLaporan(arguments: args),
            settings: settings,
          );
        }
        return MaterialPageRoute(
          builder: (_) => const HalamanRuteTidakDikenal(
            pesanError: 'Argumen data rincian laporan tidak valid atau kosong.',
          ),
          settings: settings,
        );

      case riwayatLaporan:
        return MaterialPageRoute(
          builder: (_) => const HalamanRiwayatLaporan(),
          settings: settings,
        );

      case titikRawan:
        return MaterialPageRoute(
          builder: (_) => const HalamanTitikRawan(),
          settings: settings,
        );

      case kontakDarurat:
        return MaterialPageRoute(
          builder: (_) => const HalamanKontakDarurat(),
          settings: settings,
        );

      case panduanHukum:
        return MaterialPageRoute(
          builder: (_) => const HalamanPanduanHukum(),
          settings: settings,
        );

      case tentangAplikasi:
        return MaterialPageRoute(
          builder: (_) => const HalamanTentangAplikasi(),
          settings: settings,
        );

      default:
        return MaterialPageRoute(
          builder: (_) => HalamanRuteTidakDikenal(
            pesanError: 'Rute "${settings.name}" tidak ditemukan dalam sistem Anpundung.',
          ),
          settings: settings,
        );
    }
  }

  /// Penanganan rute yang tidak dikenal (Fallback 404)
  static Route<dynamic> unknownRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (_) => HalamanRuteTidakDikenal(
        pesanError: 'Rute "${settings.name}" tidak terdaftar dalam sistem Anpundung.',
      ),
      settings: settings,
    );
  }
}

/// Tampilan halaman fallback jika rute tidak ditemukan (404 Not Found)
class HalamanRuteTidakDikenal extends StatelessWidget {
  final String pesanError;

  const HalamanRuteTidakDikenal({
    super.key,
    required this.pesanError,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Halaman Tidak Ditemukan'),
        backgroundColor: const Color(0xFF163172),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.error_outline_rounded,
                  size: 72,
                  color: Colors.red.shade700,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Galat 404: Rute Tidak Dikenal',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF163172),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                pesanError,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade700,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 28),
              FilledButton.icon(
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    AppRoutes.utama,
                    (route) => false,
                  );
                },
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFF163172),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 14,
                  ),
                ),
                icon: const Icon(Icons.home_rounded),
                label: const Text('Kembali ke Beranda Anpundung'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
