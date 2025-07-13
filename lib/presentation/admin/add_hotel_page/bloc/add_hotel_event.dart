import 'package:project_akhir_pam_lanjut_115/data/model/request/admin/add_hotel_request_model.dart';

abstract class AddHotelEvent {}

class AddHotelSubmitted extends AddHotelEvent {
  final AddHotelRequestModel request;

  AddHotelSubmitted(this.request);
}
