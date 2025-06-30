part of 'get_all_hotel_bloc.dart';

abstract class GetAllHotelEvent {}

class FetchAllHotelEvent extends GetAllHotelEvent {}

class SearchHotelByKotaEvent extends GetAllHotelEvent {
  final String keyword;

  SearchHotelByKotaEvent(this.keyword);
}
