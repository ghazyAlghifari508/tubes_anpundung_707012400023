import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/bookmark_cubit.dart';
import 'cubit/laporan_cubit.dart';
import 'cubit/theme_cubit.dart';
import 'navigation/app_routes.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const AnpundungApp());
}

/// Root widget aplikasi Anpundung (Anti Pungli Bandung)
/// Proyek Tugas Akhir / Modul VI (Manajemen State & Theming Material 3)
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
        BlocProvider<ThemeCubit>(
          create: (_) => ThemeCubit(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp(
            title: 'Anpundung - Anti Pungli Bandung',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeMode,
            initialRoute: AppRoutes.utama,
            onGenerateRoute: AppRoutes.generateRoute,
            onUnknownRoute: AppRoutes.unknownRoute,
          );
        },
      ),
    );
  }
}
