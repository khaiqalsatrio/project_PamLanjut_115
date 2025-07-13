import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_akhir_pam_lanjut_115/data/repository/admin_repository.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/admin/add_hotel_page/bloc/add_hotel_event.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/admin/add_hotel_page/bloc/add_hotel_state.dart';

class AddHotelBloc extends Bloc<AddHotelEvent, AddHotelState> {
  final AdminRepository repository;

  AddHotelBloc(this.repository) : super(AddHotelInitial()) {
    on<AddHotelSubmitted>((event, emit) async {
      emit(AddHotelLoading());
      final result = await repository.addHotel(event.request);
      result.fold(
        (error) => emit(AddHotelFailure(error)),
        (success) => emit(AddHotelSuccess()),
      );
    });
  }
}
