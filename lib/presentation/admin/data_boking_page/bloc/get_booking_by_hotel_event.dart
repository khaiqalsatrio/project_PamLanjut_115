abstract class GetBookingByHotelEvent {}

class GetBookingByHotelRequested extends GetBookingByHotelEvent {
  GetBookingByHotelRequested();
}

class ConfirmBookingRequested extends GetBookingByHotelEvent {
  final int bookingId;

  ConfirmBookingRequested(this.bookingId);
}
