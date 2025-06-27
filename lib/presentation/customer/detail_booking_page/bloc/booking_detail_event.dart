part of 'booking_detail_bloc.dart';

abstract class BookingDetailEvent {}

class GetDetailBookingEvent extends BookingDetailEvent {
  final int idBooking;

  GetDetailBookingEvent({required this.idBooking});
}
