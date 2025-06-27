part of 'booking_detail_bloc.dart';

abstract class BookingDetailState {}

class BookingDetailInitial extends BookingDetailState {}

class BookingDetailLoading extends BookingDetailState {}

class BookingDetailSuccess extends BookingDetailState {
  final List<DataBooking> bookings;

  BookingDetailSuccess(this.bookings);
}

class BookingDetailFailure extends BookingDetailState {
  final String message;

  BookingDetailFailure(this.message);
}
