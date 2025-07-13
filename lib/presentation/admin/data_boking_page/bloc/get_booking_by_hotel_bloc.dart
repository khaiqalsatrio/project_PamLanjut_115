import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_akhir_pam_lanjut_115/data/repository/admin_repository.dart';
import 'get_booking_by_hotel_event.dart';
import 'get_booking_by_hotel_state.dart';

class GetBookingByHotelBloc
    extends Bloc<GetBookingByHotelEvent, GetBookingByHotelState> {
  final AdminRepository repository;

  GetBookingByHotelBloc(this.repository) : super(GetBookingByHotelInitial()) {
    on<GetBookingByHotelRequested>(_onGetBookingByHotelRequested);
    on<ConfirmBookingRequested>(
      _onConfirmBookingRequested,
    ); // ✅ Ditempatkan di constructor
  }

  void _onGetBookingByHotelRequested(
    GetBookingByHotelRequested event,
    Emitter<GetBookingByHotelState> emit,
  ) async {
    emit(GetBookingByHotelLoading());

    final result = await repository.getBookingByHotel();

    result.fold(
      (error) => emit(GetBookingByHotelError(error)),
      (bookings) => emit(GetBookingByHotelLoaded(bookings)),
    );
  }

  void _onConfirmBookingRequested(
    ConfirmBookingRequested event,
    Emitter<GetBookingByHotelState> emit,
  ) async {
    emit(ConfirmBookingLoading());

    final result = await repository.confirmBooking(event.bookingId);

    result.fold((error) => emit(ConfirmBookingError(error)), (success) {
      if (success) {
        emit(ConfirmBookingSuccess("Booking berhasil dikonfirmasi"));
        add(GetBookingByHotelRequested()); // Ambil ulang data booking
      } else {
        emit(ConfirmBookingError("Gagal konfirmasi booking"));
      }
    });
  }
}
