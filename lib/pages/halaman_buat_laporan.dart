import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/laporan_cubit.dart';

/// Halaman Formulir Pengaduan Pungli Baru
/// Memungkinkan warga Kota Bandung memasukkan laporan pungli secara cepat dan aman.
class HalamanBuatLaporan extends StatefulWidget {
  const HalamanBuatLaporan({super.key});

  @override
  State<HalamanBuatLaporan> createState() => _HalamanBuatLaporanState();
}

class _HalamanBuatLaporanState extends State<HalamanBuatLaporan> {
  final _formKey = GlobalKey<FormState>();
  final _judulController = TextEditingController(
    text: 'Pungli Parkir Cihampelas Rp 15.000',
  );
  final _lokasiController = TextEditingController(
    text: 'Jl. Cihampelas No. 45, Bandung Wetan',
  );
  final _terlaporController = TextEditingController(
    text: 'Oknum Jukir Liar Tanpa Karcis',
  );
  final _nominalController = TextEditingController(
    text: 'Rp 15.000',
  );
  final _deskripsiController = TextEditingController(
    text:
        'Jukir liar memaksa tarif parkir motor Rp 15.000 tanpa karcis resmi Dishub.',
  );

  String _kategoriTerpilih = 'Parkir Liar';
  bool _isAnonim = true;
  bool _sedangMengirim = false; // State lokal dengan setState()

  final List<String> _kategoriList = [
    'Parkir Liar',
    'Pendidikan',
    'Pasar & PKL',
    'Kelurahan & Izin',
    'Layanan Kesehatan',
    'Lainnya',
  ];

  @override
  void dispose() {
    _judulController.dispose();
    _lokasiController.dispose();
    _terlaporController.dispose();
    _nominalController.dispose();
    _deskripsiController.dispose();
    super.dispose();
  }

  Future<void> _kirimLaporan() async {
    if (_sedangMengirim) return;

    if (_formKey.currentState!.validate()) {
      setState(() {
        _sedangMengirim = true;
      });

      // Simulasi proses validasi dan pengiriman data ke server Saber Pungli Bandung
      await Future.delayed(const Duration(milliseconds: 1200));

      if (!mounted) return;

      final judul = _judulController.text.trim();
      final lokasi = _lokasiController.text.trim();
      final terlapor = _terlaporController.text.trim();
      final nominal = _nominalController.text.trim().isEmpty
          ? 'Tidak ada nominal'
          : _nominalController.text.trim();
      final deskripsi = _deskripsiController.text.trim();

      // Memperbarui shared state melalui LaporanCubit
      context.read<LaporanCubit>().tambahLaporan(
            judul: judul,
            kategori: _kategoriTerpilih,
            lokasi: lokasi,
            terlapor: terlapor.isEmpty ? 'Oknum Belum Teridentifikasi' : terlapor,
            nominal: nominal,
            deskripsi: deskripsi,
            isAnonim: _isAnonim,
          );

      setState(() {
        _sedangMengirim = false;
      });

      final pesan =
          'Laporan pengaduan "$judul" berhasil dikirim dan dicatat ke Satgas Saber Pungli Bandung!';
      Navigator.pop(context, pesan);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      appBar: AppBar(
        title: const Text('Buat Laporan Pungli'),
        backgroundColor: const Color(0xFF163172),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Banner Keamanan & Kerahasiaan
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F0FE),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFB8D3FE)),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.security_rounded,
                      color: Color(0xFF163172),
                      size: 24,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Kerahasiaan identitas Anda dijamin undang-undang perlindungan pelapor (Whistleblower).',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF163172),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Dropdown Kategori
              const Text(
                'Kategori Pungutan Liar',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF163172),
                ),
              ),
              const SizedBox(height: 6),
              DropdownButtonFormField<String>(
                initialValue: _kategoriTerpilih,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                items: _kategoriList.map((String k) {
                  return DropdownMenuItem<String>(
                    value: k,
                    child: Text(k),
                  );
                }).toList(),
                onChanged: (val) {
                  if (val != null) {
                    setState(() => _kategoriTerpilih = val);
                  }
                },
              ),
              const SizedBox(height: 14),

              // Judul Laporan
              const Text(
                'Judul Aduan Pungli',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF163172),
                ),
              ),
              const SizedBox(height: 6),
              TextFormField(
                controller: _judulController,
                decoration: InputDecoration(
                  hintText: 'Contoh: Getok tarif parkir motor depan Mall BEC',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Judul aduan wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 14),

              // Lokasi Kejadian
              const Text(
                'Lokasi Kejadian (Kota Bandung)',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF163172),
                ),
              ),
              const SizedBox(height: 6),
              TextFormField(
                controller: _lokasiController,
                decoration: InputDecoration(
                  hintText: 'Contoh: Jl. Purnawarman No. 13, Bandung Wetan',
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: const Icon(Icons.location_on_rounded),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Lokasi kejadian wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 14),

              // Terlapor & Nominal
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Pihak Terlapor',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF163172),
                          ),
                        ),
                        const SizedBox(height: 6),
                        TextFormField(
                          controller: _terlaporController,
                          decoration: InputDecoration(
                            hintText: 'Oknum Jukir',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Nominal Diminta',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF163172),
                          ),
                        ),
                        const SizedBox(height: 6),
                        TextFormField(
                          controller: _nominalController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'Rp 10.000',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // Deskripsi & Kronologi
              const Text(
                'Kronologi & Kesaksian Peristiwa',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF163172),
                ),
              ),
              const SizedBox(height: 6),
              TextFormField(
                controller: _deskripsiController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText:
                      'Tuliskan detail kronologi, waktu kejadian, dan tindakan pemaksaan...',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Deskripsi kronologi wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),

              // Switch Anonim
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text(
                  'Kirim sebagai Pelapor Anonim',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                subtitle: const Text(
                  'Nama dan kontak Anda tidak akan ditampilkan ke publik atau instansi terlapor.',
                  style: TextStyle(fontSize: 12),
                ),
                value: _isAnonim,
                activeTrackColor: const Color(0xFF163172),
                onChanged: (val) => setState(() => _isAnonim = val),
              ),
              const SizedBox(height: 20),

              // Tombol Kirim
              SizedBox(
                width: double.infinity,
                height: 52,
                child: FilledButton(
                  onPressed: _sedangMengirim ? null : _kirimLaporan,
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFFE53935),
                    disabledBackgroundColor:
                        const Color(0xFFE53935).withValues(alpha: 0.6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: _sedangMengirim
                      ? const Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.2,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 8),
                            Flexible(
                              child: Text(
                                'Sedang Mengirim Laporan...',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        )
                      : const Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.send_rounded,
                                color: Colors.white, size: 20),
                            SizedBox(width: 8),
                            Flexible(
                              child: Text(
                                'Kirim Laporan Pungli',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
