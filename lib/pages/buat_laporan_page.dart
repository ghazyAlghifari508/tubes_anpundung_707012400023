import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/laporan_model.dart';

class BuatLaporanPage extends StatefulWidget {
  const BuatLaporanPage({super.key});

  @override
  State<BuatLaporanPage> createState() => _BuatLaporanPageState();
}

class _BuatLaporanPageState extends State<BuatLaporanPage> {
  final _formKey = GlobalKey<FormState>();

  final _namaController = TextEditingController();
  final _emailController = TextEditingController();
  final _judulController = TextEditingController();
  final _lokasiController = TextEditingController();
  final _nominalController = TextEditingController();
  final _deskripsiController = TextEditingController();

  String _kategori = 'Parkir Liar';
  String _urgensi = 'Normal'; // 'Normal' atau 'Mendesak'
  bool _setujuKerahasiaan = false;
  bool _sedangMengirim = false;

  final List<String> _daftarKategori = [
    'Parkir Liar',
    'Perizinan',
    'Pasar & PKL',
  ];

  @override
  void initState() {
    super.initState();
    _namaController.addListener(_updateStatusForm);
    _emailController.addListener(_updateStatusForm);
    _judulController.addListener(_updateStatusForm);
    _lokasiController.addListener(_updateStatusForm);
    _nominalController.addListener(_updateStatusForm);
    _deskripsiController.addListener(_updateStatusForm);
  }

  @override
  void dispose() {
    _namaController.dispose();
    _emailController.dispose();
    _judulController.dispose();
    _lokasiController.dispose();
    _nominalController.dispose();
    _deskripsiController.dispose();
    super.dispose();
  }

  void _updateStatusForm() {
    setState(() {});
  }

  bool get _isFormValid {
    return _namaController.text.trim().isNotEmpty &&
        _emailController.text.trim().isNotEmpty &&
        _emailController.text.contains('@') &&
        _judulController.text.trim().isNotEmpty &&
        _lokasiController.text.trim().isNotEmpty &&
        _nominalController.text.trim().isNotEmpty &&
        _deskripsiController.text.trim().isNotEmpty &&
        _setujuKerahasiaan;
  }

  Future<void> _kirimLaporan() async {
    if (!_isFormValid) return;

    setState(() {
      _sedangMengirim = true;
    });

    // Simulasi pengiriman data ke server posko penindakan
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    final idBaru = 'LPR-BDG-00${context.read<LaporanModel>().totalLaporan + 1}';
    final laporanBaru = Laporan(
      id: idBaru,
      namaPelapor: _namaController.text.trim(),
      emailPelapor: _emailController.text.trim(),
      judulLaporan: _judulController.text.trim(),
      lokasi: _lokasiController.text.trim(),
      kategori: _kategori,
      nominal: _nominalController.text.trim(),
      urgensi: _urgensi,
      status: 'Diproses',
      tanggal: '07 Okt 2026, 21:30',
      deskripsi: _deskripsiController.text.trim(),
    );

    context.read<LaporanModel>().tambahLaporan(laporanBaru);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Laporan berhasil dikirim ke Satgas Saber Pungli Bandung! (ID: $idBaru)',
        ),
        backgroundColor: Colors.green.shade800,
        behavior: SnackBarBehavior.floating,
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Pengaduan Pungli'),
        backgroundColor: const Color(0xFF163172),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Card
              Card(
                color: const Color(0xFF163172).withValues(alpha: 0.05),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(
                    color: const Color(0xFF163172).withValues(alpha: 0.2),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Icon(Icons.lock, color: Color(0xFF163172)),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Kerahasiaan identitas pelapor (Whistleblower) dijamin penuh oleh Undang-Undang & Satgas Saber Pungli.',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF163172),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Data Pelapor
              const Text(
                'Data Pelapor',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF163172),
                ),
              ),
              const SizedBox(height: 8),

              TextFormField(
                controller: _namaController,
                decoration: InputDecoration(
                  labelText: 'Nama Lengkap Pelapor',
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email Aktif (untuk bukti aduan)',
                  prefixIcon: const Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  helperText: _emailController.text.isNotEmpty &&
                          !_emailController.text.contains('@')
                      ? 'Format email harus mengandung @'
                      : null,
                  helperStyle: const TextStyle(color: Colors.red),
                ),
              ),
              const SizedBox(height: 16),

              // Rincian Kejadian Pungli
              const Text(
                'Rincian Tindak Pungli',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF163172),
                ),
              ),
              const SizedBox(height: 8),

              TextFormField(
                controller: _judulController,
                decoration: InputDecoration(
                  labelText: 'Judul Laporan / Pokok Aduan',
                  hintText: 'Contoh: Pungutan Parkir Liar di Kawasan Wisata',
                  prefixIcon: const Icon(Icons.title),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 12),

              // Dropdown Sektor Pungli
              DropdownButtonFormField<String>(
                initialValue: _kategori,
                decoration: InputDecoration(
                  labelText: 'Sektor / Bidang Pungli',
                  prefixIcon: const Icon(Icons.category),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                items: _daftarKategori.map((k) {
                  return DropdownMenuItem(value: k, child: Text(k));
                }).toList(),
                onChanged: (val) {
                  if (val != null) {
                    setState(() {
                      _kategori = val;
                    });
                  }
                },
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _lokasiController,
                decoration: InputDecoration(
                  labelText: 'Lokasi Kejadian (Kota Bandung)',
                  hintText: 'Contoh: Jl. Braga No. 10 / Pasar Baru',
                  prefixIcon: const Icon(Icons.pin_drop),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _nominalController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Dugaan Nominal Pungutan',
                  hintText: 'Contoh: Rp 10.000 / Rp 50.000',
                  prefixIcon: const Icon(Icons.attach_money),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _deskripsiController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Kronologi / Modus Operandi',
                  hintText: 'Jelaskan kronologi kejadian dan ciri-ciri pelaku...',
                  prefixIcon: const Icon(Icons.description),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 16),

              // RadioButton / RadioListTile Tingkat Urgensi
              const Text(
                'Tingkat Urgensi Penindakan',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF163172),
                ),
              ),
              const SizedBox(height: 4),
              RadioGroup<String>(
                groupValue: _urgensi,
                onChanged: (val) {
                  if (val != null) {
                    setState(() {
                      _urgensi = val;
                    });
                  }
                },
                child: Column(
                  children: [
                    RadioListTile<String>(
                      title: const Text('Normal (Penyelidikan Berkala)'),
                      subtitle: const Text(
                        'Dugaan pungli tanpa intimidasi fisik langsung',
                        style: TextStyle(fontSize: 11),
                      ),
                      value: 'Normal',
                      activeColor: const Color(0xFF163172),
                    ),
                    RadioListTile<String>(
                      title: const Text('Mendesak (Operasi Tangkap Tangan)'),
                      subtitle: const Text(
                        'Pelaku sedang beraksi di tempat dengan ancaman / paksaan',
                        style: TextStyle(fontSize: 11),
                      ),
                      value: 'Mendesak',
                      activeColor: Colors.red.shade700,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),

              // Checkbox Persetujuan & Komitmen Kerahasiaan
              CheckboxListTile(
                value: _setujuKerahasiaan,
                title: const Text(
                  'Saya menyatakan informasi laporan ini dibuat secara jujur tanpa rekayasa dan siap diverifikasi oleh Satgas Saber Pungli.',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                ),
                activeColor: const Color(0xFF163172),
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
                onChanged: (val) {
                  setState(() {
                    _setujuKerahasiaan = val ?? false;
                  });
                },
              ),
              const SizedBox(height: 16),

              // Tombol Submit dengan Status Loading
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed:
                      (_isFormValid && !_sedangMengirim) ? _kirimLaporan : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF163172),
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: Colors.grey.shade300,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: _sedangMengirim
                      ? const SizedBox(
                          height: 22,
                          width: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            color: Colors.white,
                          ),
                        )
                      : const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.send),
                            SizedBox(width: 8),
                            Text(
                              'Kirim Pengaduan Pungli',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
