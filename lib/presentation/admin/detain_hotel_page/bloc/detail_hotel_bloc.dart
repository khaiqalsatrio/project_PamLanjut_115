import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_akhir_pam_lanjut_115/data/repository/admin_repository.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/admin/detain_hotel_page/bloc/detail_hotel_event.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/admin/detain_hotel_page/bloc/detail_hotel_state.dart';

class DetailHotelBloc extends Bloc<DetailHotelEvent, DetailHotelState> {
  final AdminRepository repository;

  DetailHotelBloc(this.repository) : super(DetailHotelInitial()) {
    on<LoadDetailHotelEvent>((event, emit) async {
      emit(DetailHotelLoading());

      final result = await repository.getHotelDetail();
      final imageResult =
          await repository.getHotelImageByToken(); // 🔥 TAMBAHKAN INI

      if (result.isLeft()) {
        emit(DetailHotelError(result.fold((l) => l, (_) => '')));
        return;
      }

      final data = result.getOrElse(() => throw Exception('No data')).data;
      if (data == null || data.isEmpty) {
        emit(DetailHotelError("Data hotel kosong"));
        return;
      }

      final hotel = data.first;

      // ✅ Cek apakah image berhasil diambil
      if (imageResult.isRight()) {
        final imageBytes = imageResult.getOrElse(() => Uint8List(0));
        emit(DetailHotelLoaded(hotel, imageBytes));
      } else {
        // Gambar gagal, tapi data tetap ditampilkan
        emit(DetailHotelLoaded(hotel, null));
      }
    });
  }
}
