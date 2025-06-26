import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_akhir_pam_lanjut_115/data/model/response/admin/get_hotel_by_user_response_model.dart';
import 'package:project_akhir_pam_lanjut_115/data/repository/admin_repository.dart';

part 'get_hotel_event.dart';
part 'get_hotel_state.dart';

class GetHotelBloc extends Bloc<GetHotelEvent, GetHotelState> {
  final AdminRepository repository;
  GetHotelBloc(this.repository) : super(GetHotelInitial()) {
    on<FetchUserHotels>(_onFetchUserHotels);
  }

  Future<void> _onFetchUserHotels(
    FetchUserHotels event,
    Emitter<GetHotelState> emit,
  ) async {
    emit(GetHotelLoading());
    final result = await repository.getHotel();
    result.fold(
      (error) => emit(GetHotelError(error)),
      (data) => emit(GetHotelLoaded(data)),
    );
  }
}
