part of 'hotel_list_bloc.dart';

abstract class HotelListState {}

class HotelListInitial extends HotelListState {}

class HotelListLoading extends HotelListState {}

class HotelListSuccess extends HotelListState {
  final List<all_model.DataHotel> hotels;

  HotelListSuccess(this.hotels);
}

class HotelListFailure extends HotelListState {
  final String message;

  HotelListFailure(this.message);
}
