import 'package:project_akhir_pam_lanjut_115/data/model/response/admin/get_kamar_response_model.dart';

abstract class GetKamarState {}

class GetKamarInitial extends GetKamarState {}

class GetKamarLoading extends GetKamarState {}

class GetKamarSuccess extends GetKamarState {
  final List<DataKamarAdmin> kamar;

  GetKamarSuccess(this.kamar);
}

class GetKamarFailure extends GetKamarState {
  final String message;

  GetKamarFailure(this.message);
}
