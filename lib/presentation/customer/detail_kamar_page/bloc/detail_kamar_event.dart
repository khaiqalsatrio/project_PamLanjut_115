part of 'detail_kamar_bloc.dart';

abstract class DetailKamarEvent {}

class GetKamarByHotelEvent extends DetailKamarEvent {
  final int idHotel;

  GetKamarByHotelEvent({required this.idHotel});
}
