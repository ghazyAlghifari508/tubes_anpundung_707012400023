import 'package:flutter/foundation.dart';

class Laporan {
  final String id;
  final String namaPelapor;
  final String emailPelapor;
  final String judulLaporan;
  final String lokasi;
  final String kategori; // 'Parkir Liar', 'Perizinan', 'Pasar & PKL'
  final String nominal;
  final String urgensi; // 'Mendesak' / 'Normal'
  String status; // 'Diproses' / 'Terverifikasi Selesai'
  final String tanggal;
  final String deskripsi;

  Laporan({
    required this.id,
    required this.namaPelapor,
    required this.emailPelapor,
    required this.judulLaporan,
    required this.lokasi,
    required this.kategori,
    required this.nominal,
    required this.urgensi,
    required this.status,
    required this.tanggal,
    required this.deskripsi,
  });
}

class LaporanModel extends ChangeNotifier {
  final List<Laporan> _daftarLaporan = [
    Laporan(
      id: 'LPR-BDG-001',
      namaPelapor: 'Ahmad Fauzi',
      emailPelapor: 'ahmad.fauzi@gmail.com',
      judulLaporan: 'Tarif Parkir Liar Rp 10.000 Tanpa Karcis Resmi',
      lokasi: 'Jl. Braga No. 45, Sumur Bandung',
      kategori: 'Parkir Liar',
      nominal: 'Rp 10.000',
      urgensi: 'Normal',
      status: 'Diproses',
      tanggal: '07 Okt 2026, 09:15',
      deskripsi:
          'Juru parkir tidak mengenakan seragam resmi Dishub dan mematok tarif parkir motor sebesar Rp 10.000 tanpa memberikan karcis resmi Kota Bandung.',
    ),
    Laporan(
      id: 'LPR-BDG-002',
      namaPelapor: 'Siti Rahmawati',
      emailPelapor: 'siti.rahma@gmail.com',
      judulLaporan: 'Pungutan Liar Pengurusan Berkas Kependudukan',
      lokasi: 'Kantor Kelurahan Sukajadi, Bandung',
      kategori: 'Perizinan',
      nominal: 'Rp 50.000',
      urgensi: 'Mendesak',
      status: 'Terverifikasi Selesai',
      tanggal: '06 Okt 2026, 14:30',
      deskripsi:
          'Oknum petugas meminta biaya administrasi ilegal sebesar Rp 50.000 untuk penerbitan surat pengantar, padahal layanan dinyatakan bebas biaya (gratis).',
    ),
    Laporan(
      id: 'LPR-BDG-003',
      namaPelapor: 'Budi Santoso',
      emailPelapor: 'budi.santoso@gmail.com',
      judulLaporan: 'Kutipan Ilegal Retribusi Lapak Pedagang Kaki Lima',
      lokasi: 'Pasar Baru Trade Center, Jl. Otto Iskandar Dinata',
      kategori: 'Pasar & PKL',
      nominal: 'Rp 25.000',
      urgensi: 'Normal',
      status: 'Diproses',
      tanggal: '05 Okt 2026, 11:20',
      deskripsi:
          'Oknum mengatasnamakan paguyuban memungut uang keamanan harian tanpa bukti tanda terima resmi PD Pasar Bermartabat.',
    ),
  ];

  List<Laporan> get daftarLaporan => List.unmodifiable(_daftarLaporan);

  int get totalLaporan => _daftarLaporan.length;

  int get totalSelesai =>
      _daftarLaporan.where((l) => l.status == 'Terverifikasi Selesai').length;

  int get totalDiproses =>
      _daftarLaporan.where((l) => l.status == 'Diproses').length;

  int hitungKategori(String kategori) {
    return _daftarLaporan.where((l) => l.kategori == kategori).length;
  }

  void tambahLaporan(Laporan laporan) {
    _daftarLaporan.insert(0, laporan);
    notifyListeners();
  }

  void tandaiSelesai(String id) {
    final index = _daftarLaporan.indexWhere((l) => l.id == id);
    if (index != -1) {
      _daftarLaporan[index].status = 'Terverifikasi Selesai';
      notifyListeners();
    }
  }
}
