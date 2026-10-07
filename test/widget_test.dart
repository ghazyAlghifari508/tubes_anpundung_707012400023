import 'package:flutter_test/flutter_test.dart';
import 'package:tubes_anpundung_707012400023/model/laporan_model.dart';
import 'package:tubes_anpundung_707012400023/main.dart';

void main() {
  group('LaporanModel Unit Tests', () {
    test('Inisialisasi awal LaporanModel memuat 3 data aduan pungli', () {
      final model = LaporanModel();
      expect(model.totalLaporan, 3);
      expect(model.totalDiproses, 2);
      expect(model.totalSelesai, 1);
      expect(model.hitungKategori('Parkir Liar'), 1);
      expect(model.hitungKategori('Perizinan'), 1);
      expect(model.hitungKategori('Pasar & PKL'), 1);
    });

    test('Penambahan aduan baru berhasil menambah list dan hitungan kategori', () {
      final model = LaporanModel();
      final laporanBaru = Laporan(
        id: 'LPR-BDG-004',
        namaPelapor: 'Ghazy Nabil Alghfari',
        emailPelapor: 'alghifarighazy508@gmail.com',
        judulLaporan: 'Pungutan Liar Tiket Parkir Alun-alun Bandung',
        lokasi: 'Jl. Asia Afrika, Bandung',
        kategori: 'Parkir Liar',
        nominal: 'Rp 15.000',
        urgensi: 'Mendesak',
        status: 'Diproses',
        tanggal: '07 Okt 2026, 21:35',
        deskripsi: 'Juru parkir liar memungut biaya tidak resmi di trotoar jalan.',
      );

      model.tambahLaporan(laporanBaru);

      expect(model.totalLaporan, 4);
      expect(model.daftarLaporan.first.id, 'LPR-BDG-004');
      expect(model.hitungKategori('Parkir Liar'), 2);
      expect(model.totalDiproses, 3);
    });

    test('Tandai selesai mengubah status laporan menjadi Terverifikasi Selesai', () {
      final model = LaporanModel();
      expect(model.daftarLaporan[0].status, 'Diproses');

      model.tandaiSelesai('LPR-BDG-001');

      expect(model.daftarLaporan[0].status, 'Terverifikasi Selesai');
      expect(model.totalSelesai, 2);
    });
  });

  group('Widget Tests', () {
    testWidgets('Smoke test render AnpundungApp', (WidgetTester tester) async {
      await tester.pumpWidget(const AnpundungApp());
      await tester.pump();

      expect(find.text('Anpundung Mobile'), findsOneWidget);
      expect(find.text('Lapor Pungli'), findsOneWidget);
      expect(find.text('KOTA BANDUNG'), findsOneWidget);
    });
  });
}
