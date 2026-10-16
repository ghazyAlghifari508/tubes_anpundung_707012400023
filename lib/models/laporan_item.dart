/// Model data laporan pengaduan pungli untuk aplikasi Anpundung Mobile
class LaporanItem {
  final String id;
  final String judul;
  final String kategori;
  final String lokasi;
  final String terlapor;
  final String nominal;
  final String tanggal;
  final String status; // 'Investigasi', 'Verifikasi', 'Selesai'
  final String deskripsi;
  final String tindakLanjut;
  final bool isAnonim;

  const LaporanItem({
    required this.id,
    required this.judul,
    required this.kategori,
    required this.lokasi,
    required this.terlapor,
    required this.nominal,
    required this.tanggal,
    required this.status,
    required this.deskripsi,
    required this.tindakLanjut,
    this.isAnonim = true,
  });

  LaporanItem copyWith({
    String? id,
    String? judul,
    String? kategori,
    String? lokasi,
    String? terlapor,
    String? nominal,
    String? tanggal,
    String? status,
    String? deskripsi,
    String? tindakLanjut,
    bool? isAnonim,
  }) {
    return LaporanItem(
      id: id ?? this.id,
      judul: judul ?? this.judul,
      kategori: kategori ?? this.kategori,
      lokasi: lokasi ?? this.lokasi,
      terlapor: terlapor ?? this.terlapor,
      nominal: nominal ?? this.nominal,
      tanggal: tanggal ?? this.tanggal,
      status: status ?? this.status,
      deskripsi: deskripsi ?? this.deskripsi,
      tindakLanjut: tindakLanjut ?? this.tindakLanjut,
      isAnonim: isAnonim ?? this.isAnonim,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LaporanItem &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
