import 'package:flutter_bloc/flutter_bloc.dart';

/// Cubit untuk mengelola bookmark lokasi / titik rawan pungli yang dipantau warga
class BookmarkTitikRawanCubit extends Cubit<Set<String>> {
  BookmarkTitikRawanCubit() : super({'TR-BDG-01'}); // Default: Jl. Asia Afrika dipantau

  void toggleBookmark(String idTitikRawan) {
    if (state.contains(idTitikRawan)) {
      batalPantau(idTitikRawan);
    } else {
      pantau(idTitikRawan);
    }
  }

  void pantau(String idTitikRawan) {
    emit({...state, idTitikRawan});
  }

  void batalPantau(String idTitikRawan) {
    final baru = Set<String>.from(state)..remove(idTitikRawan);
    emit(baru);
  }

  bool isDipantau(String idTitikRawan) {
    return state.contains(idTitikRawan);
  }
}
