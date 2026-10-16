import 'package:flutter/material.dart';
import '../navigation/app_routes.dart';

/// Halaman Kategori Pungli menggunakan DefaultTabController, TabBar, dan TabBarView
/// Mengelompokkan berbagai modus pungutan liar di wilayah Kota Bandung.
class HalamanKategoriPungli extends StatelessWidget {
  const HalamanKategoriPungli({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Column(
        children: [
          // Header TabBar
          Container(
            color: Colors.white,
            child: const TabBar(
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              labelColor: Color(0xFF163172),
              unselectedLabelColor: Colors.grey,
              indicatorColor: Color(0xFF163172),
              indicatorWeight: 3,
              labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
              tabs: [
                Tab(
                  icon: Icon(Icons.local_parking_rounded),
                  text: 'Parkir Liar',
                ),
                Tab(
                  icon: Icon(Icons.school_rounded),
                  text: 'Pendidikan',
                ),
                Tab(
                  icon: Icon(Icons.storefront_rounded),
                  text: 'Pasar & PKL',
                ),
                Tab(
                  icon: Icon(Icons.location_city_rounded),
                  text: 'Kelurahan & Izin',
                ),
              ],
            ),
          ),
          const Divider(height: 1, thickness: 1),

          // Konten TabBarView
          Expanded(
            child: TabBarView(
              children: [
                _buildTabContent(context, _dataParkir),
                _buildTabContent(context, _dataPendidikan),
                _buildTabContent(context, _dataPasar),
                _buildTabContent(context, _dataKelurahan),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabContent(
    BuildContext context,
    List<RincianLaporanArguments> items,
  ) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 14),
          elevation: 1.5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
            side: BorderSide(color: Colors.grey.shade200),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: _getStatusColor(item.status).withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          item.status,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: _getStatusColor(item.status),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      item.idLaporan,
                      style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'monospace',
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  item.judul,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF163172),
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 15,
                      color: Colors.grey.shade600,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        item.lokasi,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.person_pin_outlined,
                      size: 15,
                      color: Colors.grey.shade600,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        'Terlapor: ${item.terlapor}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Pungutan Liar Diminta',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          Text(
                            item.nominal,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFE53935),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    FilledButton.icon(
                      onPressed: () async {
                        final result = await Navigator.pushNamed(
                          context,
                          AppRoutes.rincianLaporan,
                          arguments: item,
                        );
                        if (result != null && context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(result.toString()),
                              backgroundColor: const Color(0xFF163172),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        }
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color(0xFF163172),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),
                      ),
                      icon: const Icon(Icons.arrow_forward_rounded, size: 16),
                      label: const Text('Rincian & Aksi'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Color _getStatusColor(String status) {
    if (status.contains('Selesai') || status.contains('Tuntas')) {
      return Colors.green.shade700;
    } else if (status.contains('Investigasi')) {
      return Colors.orange.shade800;
    }
    return Colors.blue.shade700;
  }

  static const List<RincianLaporanArguments> _dataParkir = [
    RincianLaporanArguments(
      idLaporan: 'PKR-BDG-001',
      judul: 'Getok Tarif Parkir Mobil Wisata Asia Afrika',
      kategori: 'Parkir Liar',
      lokasi: 'Jl. Asia Afrika (Samping Kantor Pos Lama)',
      terlapor: 'Jukir Liar Tanpa Atribut & Karcis',
      nominal: 'Rp 25.000 / Mobil',
      tanggal: '24 September 2026',
      status: 'Sedang Diinvestigasi',
      deskripsi:
          'Pengunjung dipaksa membayar di muka sebesar Rp 25.000 tanpa karcis resmi Dishub. Petugas parkir menolak memberikan bukti bayar.',
      tindakLanjut:
          'Dishub Bandung dan Tim Penindakan Saber Pungli telah melakukan razia dan mengamankan 3 pelaku untuk diproses hukum.',
    ),
    RincianLaporanArguments(
      idLaporan: 'PKR-BDG-002',
      judul: 'Pungutan Parkir Motor Trotoar Tamansari',
      kategori: 'Parkir Liar',
      lokasi: 'Jl. Tamansari No. 64 (Dekat Kampus ITB)',
      terlapor: 'Oknum Penjaga Trotoar Liar',
      nominal: 'Rp 5.000 / Motor',
      tanggal: '23 September 2026',
      status: 'Tahap Verifikasi Bukti',
      deskripsi:
          'Trotoar pejalan kaki dipatok menjadi area parkir berbayar dengan tarif motor Rp 5.000. Pejalan kaki terpaksa turun ke bahu jalan.',
      tindakLanjut:
          'Satpol PP Kota Bandung telah menerbitkan surat peringatan dan berkoordinasi dengan kepolisian untuk penertiban rutin.',
    ),
    RincianLaporanArguments(
      idLaporan: 'PKR-BDG-003',
      judul: 'Parkir Liar Bahu Jalan Pasir Kaliki',
      kategori: 'Parkir Liar',
      lokasi: 'Jl. Pasir Kaliki (Dekat Pusat Kuliner)',
      terlapor: 'Kelompok Pemuda Mengaku Pengelola',
      nominal: 'Rp 10.000 / Motor & Rp 20.000 / Mobil',
      tanggal: '21 September 2026',
      status: 'Selesai Ditindak Tegas',
      deskripsi:
          'Pungutan parkir liar di area rambu dilarang parkir. Kendaraan diparkir memakan setengah badan jalan sehingga menyebabkan kemacetan parah.',
      tindakLanjut:
          'Petugas gabungan Dishub melakukan penggembokan dan penderekan 8 unit kendaraan serta penangkapan koordinator pungli.',
    ),
  ];

  static const List<RincianLaporanArguments> _dataPendidikan = [
    RincianLaporanArguments(
      idLaporan: 'PDK-BDG-001',
      judul: 'Iuran Wajib Renovasi Gedung Sekolah Negeri',
      kategori: 'Pendidikan',
      lokasi: 'SMP Negeri Kawasan Dago, Bandung',
      terlapor: 'Oknum Pengurus Komite Sekolah',
      nominal: 'Rp 600.000 / Siswa',
      tanggal: '22 September 2026',
      status: 'Sedang Diinvestigasi',
      deskripsi:
          'Wali murid diwajibkan menyumbang dana perbaikan fasilitas sekolah yang seharusnya telah didanai oleh Bantuan Operasional Sekolah (BOS).',
      tindakLanjut:
          'Dinas Pendidikan Kota Bandung bersama Saber Pungli memanggil jajaran kepala sekolah untuk audit menyeluruh.',
    ),
    RincianLaporanArguments(
      idLaporan: 'PDK-BDG-002',
      judul: 'Biaya Tebus Ijazah & Raport Siswa',
      kategori: 'Pendidikan',
      lokasi: 'SMK Swasta Wilayah Buah Batu, Bandung',
      terlapor: 'Bagian Tata Usaha Sekolah',
      nominal: 'Rp 1.200.000 / Siswa',
      tanggal: '20 September 2026',
      status: 'Tahap Verifikasi Bukti',
      deskripsi:
          'Ijazah kelulusan siswa ditahan dan dikenakan biaya tebus administrasi kelulusan yang bertentangan dengan Surat Edaran Kemendikbud.',
      tindakLanjut:
          'Inspektorat memberikan ultimatum kepada pihak yayasan untuk segera menyerahkan seluruh ijazah tanpa syarat pungutan apa pun.',
    ),
    RincianLaporanArguments(
      idLaporan: 'PDK-BDG-003',
      judul: 'Kewajiban Pembelian Buku LKS Mandiri',
      kategori: 'Pendidikan',
      lokasi: 'SD Negeri Wilayah Kiaracondong, Bandung',
      terlapor: 'Oknum Guru & Koperasi Tertentu',
      nominal: 'Rp 180.000 / Paket',
      tanggal: '18 September 2026',
      status: 'Selesai Ditindak Tegas',
      deskripsi:
          'Siswa diwajibkan membeli buku paket LKS tertentu dengan ancaman tidak akan diberikan nilai tugas jika tidak membeli.',
      tindakLanjut:
          'Diberikan sanksi teguran keras dan uang pembelian telah dikembalikan 100% kepada seluruh orang tua siswa.',
    ),
  ];

  static const List<RincianLaporanArguments> _dataPasar = [
    RincianLaporanArguments(
      idLaporan: 'PSR-BDG-001',
      judul: 'Pungutan Sewa Lapak Ilegal PKL Cicadas',
      kategori: 'Pasar & PKL',
      lokasi: 'Sepanjang Trotoar Jl. Ahmad Yani (Cicadas)',
      terlapor: 'Oknum Ormas Penguasa Teritorial',
      nominal: 'Rp 35.000 / Hari',
      tanggal: '23 September 2026',
      status: 'Sedang Diinvestigasi',
      deskripsi:
          'Pedagang kaki lima diwajibkan menyetor uang koordinasi keamanan harian agar diperbolehkan berjualan di fasilitas umum.',
      tindakLanjut:
          'Tim Resmob Polrestabes Bandung melakukan operasi tangkap tangan terhadap 2 koordinator penarik setoran liar.',
    ),
    RincianLaporanArguments(
      idLaporan: 'PSR-BDG-002',
      judul: 'Retribusi Siluman Bongkar Muat Pasar Baru',
      kategori: 'Pasar & PKL',
      lokasi: 'Pintu Masuk Bongkar Muat Pasar Baru Bandung',
      terlapor: 'Kelompok Preman Berkedok Jasa Angkut',
      nominal: 'Rp 50.000 / Truk Box',
      tanggal: '21 September 2026',
      status: 'Tahap Verifikasi Bukti',
      deskripsi:
          'Setiap truk logistik distributor dipaksa membayar retribusi masuk liar di luar tiket gerbang resmi pengelola pasar PD Pasar Bermartabat.',
      tindakLanjut:
          'PD Pasar Bermartabat bersama Satpol PP mendirikan pos pengamanan terpadu 24 jam di pintu bongkar muat.',
    ),
    RincianLaporanArguments(
      idLaporan: 'PSR-BDG-003',
      judul: 'Pungli Iuran Sampah Fiktif Pasar Gedebage',
      kategori: 'Pasar & PKL',
      lokasi: 'Blok Sayur Mayur Pasar Induk Gedebage',
      terlapor: 'Oknum Pengurus Kebersihan Liar',
      nominal: 'Rp 15.000 / Kios / Hari',
      tanggal: '17 September 2026',
      status: 'Selesai Ditindak Tegas',
      deskripsi:
          'Kios sayur dipungut biaya sampah tambahan di luar retribusi DLH Bandung tanpa ada penarikan sampah berkala.',
      tindakLanjut:
          'Pelaku telah dijerat pasal pemerasan dan DLH mengambil alih sistem pengelolaan sampah secara resmi dan transparan.',
    ),
  ];

  static const List<RincianLaporanArguments> _dataKelurahan = [
    RincianLaporanArguments(
      idLaporan: 'KLR-BDG-001',
      judul: 'Pungli Pengurusan Surat Pindah & Domisili',
      kategori: 'Kelurahan & Izin',
      lokasi: 'Kantor Kelurahan Kawasan Bandung Timur',
      terlapor: 'Oknum Staf Pelayanan Administrasi',
      nominal: 'Rp 150.000 / Berkas',
      tanggal: '24 September 2026',
      status: 'Sedang Diinvestigasi',
      deskripsi:
          'Warga dimintai biaya percepatan pembuatan Surat Keterangan Pindah WNI (SKPWNI) dengan janji berkas selesai dalam 1 jam.',
      tindakLanjut:
          'BKPSDM dan Satgas Saber Pungli memeriksa oknum ASN dan memeriksa rekaman CCTV ruang pelayanan terpadu.',
    ),
    RincianLaporanArguments(
      idLaporan: 'KLR-BDG-002',
      judul: 'Uang Pelicin Izin Usaha Mikro (IUMK)',
      kategori: 'Kelurahan & Izin',
      lokasi: 'Kantor Kecamatan Wilayah Bojonagara, Bandung',
      terlapor: 'Oknum Tenaga Harian Lepas (THL)',
      nominal: 'Rp 250.000 / Pemohon',
      tanggal: '22 September 2026',
      status: 'Tahap Verifikasi Bukti',
      deskripsi:
          'Pelaku usaha mikro dimintai dana administrasi survei lokasi usaha padahal pembuatan IUMK dan NIB adalah program gratis pemerintah.',
      tindakLanjut:
          'Camat setempat menonaktifkan oknum yang bersangkutan dan mempermudah penerbitan izin warga secara digital.',
    ),
    RincianLaporanArguments(
      idLaporan: 'KLR-BDG-003',
      judul: 'Pungutan Legalisir Dokumen Ahli Waris',
      kategori: 'Kelurahan & Izin',
      lokasi: 'Kantor Kelurahan di Kota Bandung Pusat',
      terlapor: 'Oknum Petugas Meja Pelayanan',
      nominal: 'Rp 300.000 / Surat',
      tanggal: '16 September 2026',
      status: 'Selesai Ditindak Tegas',
      deskripsi:
          'Warga lansia yang mengurus surat pengantar penetapan ahli waris dikenai tarif sukarela namun dipatok minimal Rp 300.000.',
      tindakLanjut:
          'Inspektorat Kota Bandung menjatuhkan hukuman disiplin pemindahan tugas dan pengembalian uang kepada pelapor.',
    ),
  ];
}
