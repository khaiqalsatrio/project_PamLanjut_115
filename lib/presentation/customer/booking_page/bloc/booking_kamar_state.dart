part of 'booking_kamar_bloc.dart';

abstract class BookingKamarState {}

class BookingKamarInitial extends BookingKamarState {}

class BookingKamarLoading extends BookingKamarState {}

class BookingKamarSuccess extends BookingKamarState {
  final BookingKamarResponseModel response;

  BookingKamarSuccess(this.response);
}

class BookingKamarFailure extends BookingKamarState {
  final String message;

  BookingKamarFailure(this.message);
}
