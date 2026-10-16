import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/bookmark_cubit.dart';
import 'cubit/laporan_cubit.dart';
import 'navigation/app_routes.dart';

void main() {
  runApp(const AnpundungApp());
}

/// Root widget aplikasi Anpundung (Anti Pungli Bandung)
/// Proyek Tugas Praktikum Modul V (State Management BLoC / Cubit)
/// Pengembang: Ghazy Nabil Alghfari (NIM: 707012400023 | D4SIKC 48-03)
class AnpundungApp extends StatelessWidget {
  const AnpundungApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Sediakan Cubit di akar aplikasi di atas MaterialApp / navigasi
    return MultiBlocProvider(
      providers: [
        BlocProvider<LaporanCubit>(
          create: (_) => LaporanCubit(),
        ),
        BlocProvider<BookmarkTitikRawanCubit>(
          create: (_) => BookmarkTitikRawanCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Anpundung - Anti Pungli Bandung',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF163172),
            primary: const Color(0xFF163172),
            secondary: const Color(0xFF1E56A0),
            surface: Colors.white,
          ),
          appBarTheme: const AppBarTheme(
            centerTitle: false,
            elevation: 0,
          ),
        ),
        initialRoute: AppRoutes.utama,
        onGenerateRoute: AppRoutes.generateRoute,
        onUnknownRoute: AppRoutes.unknownRoute,
      ),
    );
  }
}
