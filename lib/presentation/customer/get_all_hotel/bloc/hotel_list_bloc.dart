import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:project_akhir_pam_lanjut_115/data/model/response/customer/get_all_hotel_response_model.dart'
    as all_model;

import 'package:project_akhir_pam_lanjut_115/data/repository/customer_repository.dart';

part 'hotel_list_event.dart';
part 'hotel_list_state.dart';

class HotelListBloc extends Bloc<HotelListEvent, HotelListState> {
  final CustomerRepository repository;

  HotelListBloc(this.repository) : super(HotelListInitial()) {
    on<GetAllHotelEvent>((event, emit) async {
      if (kDebugMode) print("📥 GetAllHotelEvent dipanggil...");
      emit(HotelListLoading());

      final result = await repository.getAllHotel();
      result.fold(
        (err) {
          if (kDebugMode) print("❌ Gagal ambil hotel: $err");
          emit(HotelListFailure(err));
        },
        (data) {
          final hotels = data.data ?? [];

          if (kDebugMode) {
            print("✅ Dapat ${hotels.length} hotel");
          }

          emit(HotelListSuccess(hotels));
        },
      );
    });
  }
}
