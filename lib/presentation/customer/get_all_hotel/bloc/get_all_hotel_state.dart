part of 'get_all_hotel_bloc.dart';

abstract class GetAllHotelState {}

class GetAllHotelInitial extends GetAllHotelState {}

class GetAllHotelLoading extends GetAllHotelState {}

class GetAllHotelSuccess extends GetAllHotelState {
  final List<all_model.DataHotel> hotels;

  GetAllHotelSuccess(this.hotels);
}

class GetAllHotelFailure extends GetAllHotelState {
  final String message;

  GetAllHotelFailure(this.message);
}
