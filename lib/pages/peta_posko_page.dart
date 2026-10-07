import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PetaPoskoPage extends StatefulWidget {
  const PetaPoskoPage({super.key});

  @override
  State<PetaPoskoPage> createState() => _PetaPoskoPageState();
}

class _PetaPoskoPageState extends State<PetaPoskoPage> {
  static const LatLng _pusatBandung = LatLng(-6.9126, 107.6097); // Balai Kota Bandung
  late GoogleMapController _controller;

  String _poskoTerpilih = 'Posko Utama Balai Kota Bandung';
  String _alamatTerpilih = 'Jl. Wastukancana No. 2, Sumur Bandung';
  String _kontakTerpilih = 'Call Center: (022) 4232338 / 112';

  final Set<Marker> _markers = {
    const Marker(
      markerId: MarkerId('posko_balai_kota'),
      position: LatLng(-6.9126, 107.6097),
      infoWindow: InfoWindow(
        title: 'Posko Utama Saber Pungli Balai Kota',
        snippet: 'Pusat Koordinasi Satgas & Penindakan Terpadu',
      ),
    ),
    const Marker(
      markerId: MarkerId('posko_cicaheum'),
      position: LatLng(-6.9054, 107.6548),
      infoWindow: InfoWindow(
        title: 'Posko Pantau Terminal Cicaheum',
        snippet: 'Pengawasan Retribusi & Pungli Angkutan Umum',
      ),
    ),
    const Marker(
      markerId: MarkerId('posko_pasar_baru'),
      position: LatLng(-6.9192, 107.6047),
      infoWindow: InfoWindow(
        title: 'Posko Pengawasan Pasar Baru',
        snippet: 'Pengawasan Lapak PKL & Retribusi Parkir Liar',
      ),
    ),
  };

  void _pindahKeLokasi(
    LatLng posisi,
    String nama,
    String alamat,
    String kontak,
  ) {
    setState(() {
      _poskoTerpilih = nama;
      _alamatTerpilih = alamat;
      _kontakTerpilih = kontak;
    });
    _controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: posisi, zoom: 15.5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Google Maps View
        GoogleMap(
          initialCameraPosition: const CameraPosition(
            target: _pusatBandung,
            zoom: 13.8,
          ),
          markers: _markers,
          mapType: MapType.normal,
          myLocationButtonEnabled: false,
          zoomControlsEnabled: true,
          onMapCreated: (controller) {
            _controller = controller;
          },
        ),

        // Info Card Posko Terpilih (Atas)
        Positioned(
          top: 14,
          left: 14,
          right: 14,
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: const Color(0xFF163172),
                    child: const Icon(Icons.shield, color: Colors.white, size: 22),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _poskoTerpilih,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13.5,
                            color: Color(0xFF163172),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          _alamatTerpilih,
                          style: const TextStyle(fontSize: 11.5, color: Colors.black54),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          _kontakTerpilih,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFD32F2F),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        // Chips Navigasi Cepat Lokasi Posko (Bawah)
        Positioned(
          bottom: 16,
          left: 12,
          right: 12,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildQuickChip(
                  'Posko Balai Kota (Pusat)',
                  const LatLng(-6.9126, 107.6097),
                  'Posko Utama Balai Kota Bandung',
                  'Jl. Wastukancana No. 2, Sumur Bandung',
                  'Call Center: (022) 4232338 / 112',
                ),
                const SizedBox(width: 8),
                _buildQuickChip(
                  'Posko Cicaheum',
                  const LatLng(-6.9054, 107.6548),
                  'Posko Pantau Terminal Cicaheum',
                  'Jl. Jend. A. Yani, Kiaracondong, Bandung',
                  'Posko Lapangan: 0812-3456-7890',
                ),
                const SizedBox(width: 8),
                _buildQuickChip(
                  'Posko Pasar Baru',
                  const LatLng(-6.9192, 107.6047),
                  'Posko Pengawasan Pasar Baru',
                  'Jl. Otto Iskandar Dinata, Andir, Bandung',
                  'Satgas Pasar: 0813-9876-5432',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickChip(
    String label,
    LatLng pos,
    String nama,
    String alamat,
    String kontak,
  ) {
    final bool aktif = _poskoTerpilih == nama;
    return ActionChip(
      avatar: Icon(
        Icons.location_on,
        size: 16,
        color: aktif ? Colors.white : const Color(0xFF163172),
      ),
      label: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: aktif ? Colors.white : const Color(0xFF163172),
        ),
      ),
      backgroundColor: aktif ? const Color(0xFF163172) : Colors.white,
      elevation: 2,
      onPressed: () => _pindahKeLokasi(pos, nama, alamat, kontak),
    );
  }
}
