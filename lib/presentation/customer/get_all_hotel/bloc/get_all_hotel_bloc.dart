import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:project_akhir_pam_lanjut_115/data/model/response/customer/get_all_hotel_response_model.dart'
    as all_model;

import 'package:project_akhir_pam_lanjut_115/data/repository/customer_repository.dart';

part 'get_all_hotel_event.dart';
part 'get_all_hotel_state.dart';

class GetAllHotelBloc extends Bloc<GetAllHotelEvent, GetAllHotelState> {
  final CustomerRepository repository;

  GetAllHotelBloc(this.repository) : super(GetAllHotelInitial()) {
    on<GetAllHotelEvent>((event, emit) async {
      if (kDebugMode) print("GetAllHotelEvent dipanggil!");
      emit(GetAllHotelLoading());
      final result = await repository.getAllHotel();
      result.fold(
        (err) {
          if (kDebugMode) print("Gagal ambil hotel: $err");
          emit(GetAllHotelFailure(err));
        },
        (data) {
          final hotels = data.data ?? [];
          if (kDebugMode) {
            print("Dapat ${hotels.length} hotel");
          }
          emit(GetAllHotelSuccess(hotels));
        },
      );
    });
  }
}
