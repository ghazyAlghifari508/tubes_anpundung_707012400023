import 'package:flutter/material.dart';

class KonsultasiSaberPage extends StatefulWidget {
  const KonsultasiSaberPage({super.key});

  @override
  State<KonsultasiSaberPage> createState() => _KonsultasiSaberPageState();
}

class _KonsultasiSaberPageState extends State<KonsultasiSaberPage> {
  final TextEditingController _pesanController = TextEditingController();

  final List<Map<String, dynamic>> _daftarPesan = [
    {
      'pengirim': 'petugas',
      'teks':
          'Sampurasun Warga Bandung! Ini adalah Layanan Konsultasi Cepat Satgas Saber Pungli Kota Bandung. Ada yang bisa kami bantu atau konsultasikan terkait indikasi pungli?',
      'waktu': '09:00',
    },
    {
      'pengirim': 'warga',
      'teks':
          'Selamat pagi Pak Petugas. Kalau saya menemukan oknum juru parkir meminta uang Rp 10.000 tanpa karcis resmi, apakah bukti foto dan lokasi cukup untuk diproses?',
      'waktu': '09:05',
    },
    {
      'pengirim': 'petugas',
      'teks':
          'Sangat cukup! Pastikan foto mencakup wajah pelaku atau area sekitar kejadian. Kirimkan laporan melalui menu Lapor Pungli, dan identitas Anda dijamin aman 100%. Tim penindakan lapangan akan segera diterjunkan ke lokasi.',
      'waktu': '09:07',
    },
  ];

  void _kirimPesan() {
    final teks = _pesanController.text.trim();
    if (teks.isEmpty) return;

    final now = DateTime.now();
    final jam = now.hour.toString().padLeft(2, '0');
    final menit = now.minute.toString().padLeft(2, '0');

    setState(() {
      _daftarPesan.add({
        'pengirim': 'warga',
        'teks': teks,
        'waktu': '$jam:$menit',
      });
    });

    _pesanController.clear();
  }

  @override
  void dispose() {
    _pesanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header Banner Status Petugas
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFF163172).withValues(alpha: 0.08),
            border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
          ),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: const Color(0xFF163172),
                radius: 20,
                child: const Icon(Icons.support_agent, color: Colors.white, size: 22),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Helpdesk Posko Saber Pungli Bandung',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.5),
                    ),
                    SizedBox(height: 2),
                    Row(
                      children: [
                        Icon(Icons.circle, color: Colors.green, size: 9),
                        SizedBox(width: 5),
                        Text(
                          'Online • Tim Satgas Siap Siaga 24 Jam',
                          style: TextStyle(fontSize: 11, color: Colors.black54),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Daftar Pesan Chat
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(14),
            itemCount: _daftarPesan.length,
            itemBuilder: (context, index) {
              final pesan = _daftarPesan[index];
              final bool dariWarga = pesan['pengirim'] == 'warga';

              return Align(
                alignment: dariWarga ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.78,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: dariWarga ? const Color(0xFF163172) : Colors.grey.shade200,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(14),
                      topRight: const Radius.circular(14),
                      bottomLeft: Radius.circular(dariWarga ? 14 : 2),
                      bottomRight: Radius.circular(dariWarga ? 2 : 14),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 3,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment:
                        dariWarga ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                    children: [
                      Text(
                        pesan['teks'],
                        style: TextStyle(
                          fontSize: 13,
                          color: dariWarga ? Colors.white : Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        pesan['waktu'],
                        style: TextStyle(
                          fontSize: 10,
                          color: dariWarga ? Colors.white70 : Colors.black45,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),

        // Input Bar
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 4,
                offset: const Offset(0, -1),
              ),
            ],
          ),
          child: SafeArea(
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _pesanController,
                    textInputAction: TextInputAction.send,
                    onSubmitted: (_) => _kirimPesan(),
                    decoration: InputDecoration(
                      hintText: 'Ketik pesan konsultasi ke Satgas...',
                      hintStyle: const TextStyle(fontSize: 13),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade50,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: const Color(0xFF163172),
                  radius: 22,
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white, size: 20),
                    onPressed: _kirimPesan,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
