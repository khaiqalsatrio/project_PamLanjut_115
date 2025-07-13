import 'package:project_akhir_pam_lanjut_115/data/model/response/admin/get_booking_by_hotel_response_model.dart';

abstract class GetBookingByHotelState {}

class GetBookingByHotelInitial extends GetBookingByHotelState {}

class GetBookingByHotelLoading extends GetBookingByHotelState {}

class GetBookingByHotelLoaded extends GetBookingByHotelState {
  final List<DataBookingAdmin> bookings;
  GetBookingByHotelLoaded(this.bookings);
}

class GetBookingByHotelError extends GetBookingByHotelState {
  final String message;
  GetBookingByHotelError(this.message);
}

// 🔧 Tambahan untuk konfirmasi booking
class ConfirmBookingLoading extends GetBookingByHotelState {}

class ConfirmBookingSuccess extends GetBookingByHotelState {
  final String message;
  ConfirmBookingSuccess(this.message);
}

class ConfirmBookingError extends GetBookingByHotelState {
  final String error;
  ConfirmBookingError(this.error);
}
