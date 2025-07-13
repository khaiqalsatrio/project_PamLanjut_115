import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_akhir_pam_lanjut_115/data/repository/customer_repository.dart';
import 'get_riwayat_booking_event.dart';
import 'get_riwayat_booking_state.dart';

class GetRiwayatBookingBloc
    extends Bloc<GetRiwayatBookingEvent, GetRiwayatBookingState> {
  final CustomerRepository repository;

  GetRiwayatBookingBloc(this.repository) : super(GetRiwayatBookingInitial()) {
    on<GetRiwayatBookingRequested>(_onRequested);
  }

  Future<void> _onRequested(
    GetRiwayatBookingRequested event,
    Emitter<GetRiwayatBookingState> emit,
  ) async {
    emit(GetRiwayatBookingLoading());

    final result = await repository.getRiwayatBooking();

    result.fold(
      (error) => emit(GetRiwayatBookingError(error)),
      (model) => emit(GetRiwayatBookingLoaded(model.data ?? [])),
    );
  }
}
