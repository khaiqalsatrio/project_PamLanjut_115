import 'package:project_akhir_pam_lanjut_115/data/model/response/customer/get_riwayat_booking_response_model.dart';

abstract class GetRiwayatBookingState {}

class GetRiwayatBookingInitial extends GetRiwayatBookingState {}

class GetRiwayatBookingLoading extends GetRiwayatBookingState {}

class GetRiwayatBookingLoaded extends GetRiwayatBookingState {
  final List<DataRiwayat> data;

  GetRiwayatBookingLoaded(this.data);
}

class GetRiwayatBookingError extends GetRiwayatBookingState {
  final String message;

  GetRiwayatBookingError(this.message);
}
