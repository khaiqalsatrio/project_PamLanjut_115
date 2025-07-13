import 'dart:typed_data';
import 'package:project_akhir_pam_lanjut_115/data/model/response/admin/get_hotel_by_user_response_model.dart';

abstract class DetailHotelState {}

class DetailHotelInitial extends DetailHotelState {}

class DetailHotelLoading extends DetailHotelState {}

class DetailHotelLoaded extends DetailHotelState {
  final DataHotel hotel;
  final Uint8List? imageBytes;

  DetailHotelLoaded(this.hotel, this.imageBytes);
}

class DetailHotelError extends DetailHotelState {
  final String message;

  DetailHotelError(this.message);
}
