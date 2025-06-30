part of 'booking_kamar_bloc.dart';

abstract class BookingKamarEvent {}

class SubmitBookingKamar extends BookingKamarEvent {
  final BookingKamarRequestModel request;

  SubmitBookingKamar(this.request);
}
