import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'model/laporan_model.dart';
import 'navigation/app_routes.dart';
import 'navigation/kerangka_navigasi.dart';
import 'pages/buat_laporan_page.dart';

void main() {
  runApp(const AnpundungApp());
}

class AnpundungApp extends StatelessWidget {
  const AnpundungApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LaporanModel(),
      child: MaterialApp(
      title: 'Anpundung Mobile - 707012400023',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF163172),
          primary: const Color(0xFF163172),
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: false,
          elevation: 0,
        ),
      ),
      initialRoute: AppRoutes.beranda,
      routes: {
        AppRoutes.beranda: (context) => const KerangkaNavigasi(),
        AppRoutes.buatLaporan: (context) => const BuatLaporanPage(),
      },
    ),
  );
}
}
