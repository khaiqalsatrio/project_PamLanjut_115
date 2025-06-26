part of 'get_hotel_bloc.dart';

abstract class GetHotelState {}

class GetHotelInitial extends GetHotelState {}

class GetHotelLoading extends GetHotelState {}

class GetHotelLoaded extends GetHotelState {
  final GetHotelByUserResponseModel data;
  GetHotelLoaded(this.data);
}

class GetHotelError extends GetHotelState {
  final String message;
  GetHotelError(this.message);
}
