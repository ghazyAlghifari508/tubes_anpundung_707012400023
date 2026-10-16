import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/laporan_item.dart';

/// State yang menampung daftar laporan pengaduan pungli warga
class LaporanState {
  final List<LaporanItem> daftarLaporan;

  const LaporanState({this.daftarLaporan = const []});

  int get totalLaporan => daftarLaporan.length;

  int get totalInvestigasi =>
      daftarLaporan.where((item) => item.status == 'Investigasi').length;

  int get totalDitindak =>
      daftarLaporan.where((item) => item.status == 'Selesai').length;

  int get totalVerifikasi =>
      daftarLaporan.where((item) => item.status == 'Verifikasi').length;

  LaporanState copyWith({List<LaporanItem>? daftarLaporan}) {
    return LaporanState(
      daftarLaporan: daftarLaporan ?? this.daftarLaporan,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LaporanState &&
          runtimeType == other.runtimeType &&
          daftarLaporan == other.daftarLaporan;

  @override
  int get hashCode => daftarLaporan.hashCode;
}

/// Cubit untuk mengelola state laporan pengaduan pungli Kota Bandung
class LaporanCubit extends Cubit<LaporanState> {
  LaporanCubit() : super(_initialState());

  static LaporanState _initialState() {
    return const LaporanState(
      daftarLaporan: [
        LaporanItem(
          id: 'AP-BDG-2026-081',
          judul: 'Pungli Tarif Parkir Getok Asia Afrika',
          kategori: 'Parkir Liar',
          lokasi: 'Jl. Asia Afrika (Dekat Gedung Merdeka), Bandung',
          terlapor: 'Oknum Jukir Liar Tanpa Karcis',
          nominal: 'Rp 20.000 (Mobil)',
          tanggal: '24 Sep 2026',
          status: 'Investigasi',
          deskripsi:
              'Pengendara dipaksa membayar tarif parkir mobil Rp 20.000 tanpa karcis resmi. Saat ditanya karcis Dishub, oknum bertindak intimidatif.',
          tindakLanjut:
              'Tim Saber Pungli Polrestabes Bandung dan Dishub telah mengamankan 2 jukir liar untuk pembinaan dan sanksi tindak pidana ringan.',
          isAnonim: true,
        ),
        LaporanItem(
          id: 'AP-BDG-2026-079',
          judul: 'Iuran Siluman Gedung SMP Negeri Bandung',
          kategori: 'Pendidikan',
          lokasi: 'Kecamatan Coblong, Kota Bandung',
          terlapor: 'Komite Sekolah Oknum Tertentu',
          nominal: 'Rp 750.000 / Siswa',
          tanggal: '22 Sep 2026',
          status: 'Verifikasi',
          deskripsi:
              'Wali murid diwajibkan membayar uang renovasi aula tanpa persetujuan Disdik Bandung dan tanpa tanda terima resmi yayasan/komite.',
          tindakLanjut:
              'Inspektorat Kota Bandung memanggil pihak kepala sekolah dan komite untuk klarifikasi dokumen administrasi keuangan BOS.',
          isAnonim: false,
        ),
        LaporanItem(
          id: 'AP-BDG-2026-075',
          judul: 'Pungli Lapak Ilegal PKL Taman Sari',
          kategori: 'Pasar & PKL',
          lokasi: 'Jl. Taman Sari (Sekitar Babakan Siliwangi)',
          terlapor: 'Organisasi Kemasyarakatan Liar',
          nominal: 'Rp 30.000 / Hari',
          tanggal: '19 Sep 2026',
          status: 'Selesai',
          deskripsi:
              'Pedagang kaki lima dimintai setoran harian dengan dalih uang keamanan wilayah oleh kelompok preman setempat.',
          tindakLanjut:
              'Satpol PP Kota Bandung bersama Satgas Saber Pungli melakukan penertiban dan memasang plang zona bebas pungli.',
          isAnonim: true,
        ),
        LaporanItem(
          id: 'AP-BDG-2026-070',
          judul: 'Pungutan Legalisir Surat Domisili Kelurahan',
          kategori: 'Kelurahan & Izin',
          lokasi: 'Kelurahan Bandung Pusat',
          terlapor: 'Oknum Staf Kelurahan',
          nominal: 'Rp 150.000',
          tanggal: '15 Sep 2026',
          status: 'Selesai',
          deskripsi:
              'Warga dipungut biaya pengurusan surat keterangan domisili padahal layanan resmi kelurahan bebas biaya (Rp 0).',
          tindakLanjut:
              'Pemberian teguran disiplin dan pengembalian uang pungutan kepada warga bersangkutan.',
          isAnonim: true,
        ),
      ],
    );
  }

  /// Menambahkan laporan aduan baru dari warga ke baris paling atas
  void tambahLaporan({
    required String judul,
    required String kategori,
    required String lokasi,
    required String terlapor,
    required String nominal,
    required String deskripsi,
    bool isAnonim = true,
  }) {
    final nextNumber = state.daftarLaporan.length + 82;
    final idBaru = 'AP-BDG-2026-${nextNumber.toString().padLeft(3, '0')}';

    final itemBaru = LaporanItem(
      id: idBaru,
      judul: judul,
      kategori: kategori,
      lokasi: lokasi,
      terlapor: terlapor,
      nominal: nominal,
      tanggal: 'Hari ini',
      status: 'Investigasi',
      deskripsi: deskripsi,
      tindakLanjut:
          'Laporan berhasil diterima Satgas Saber Pungli Bandung. Sedang dalam tahap verifikasi lapangan.',
      isAnonim: isAnonim,
    );

    final listBaru = [itemBaru, ...state.daftarLaporan];
    emit(state.copyWith(daftarLaporan: listBaru));
  }

  /// Menghapus laporan aduan berdasarkan ID
  void hapusLaporan(String id) {
    final listBaru =
        state.daftarLaporan.where((item) => item.id != id).toList();
    emit(state.copyWith(daftarLaporan: listBaru));
  }

  /// Mengosongkan daftar laporan
  void kosongkan() {
    emit(const LaporanState(daftarLaporan: []));
  }
}
