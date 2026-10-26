import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Cubit untuk mengelola preferensi mode tema aplikasi (Light / Dark)
/// Memenuhi ketentuan Modul VI Soal 2
/// Pengembang: Ghazy Nabil Alghfari (NIM: 707012400023 | D4SIKC 48-03)
class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.light);

  void toggle() {
    emit(state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark);
  }

  void setDarkMode(bool isDark) {
    emit(isDark ? ThemeMode.dark : ThemeMode.light);
  }
}
