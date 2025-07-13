import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_akhir_pam_lanjut_115/data/model/request/admin/update_kamar_request_model.dart';
import 'package:project_akhir_pam_lanjut_115/data/repository/admin_repository.dart';

part 'update_kamar_event.dart';
part 'update_kamar_state.dart';

class UpdateKamarBloc extends Bloc<UpdateKamarEvent, UpdateKamarState> {
  final AdminRepository repository;

  UpdateKamarBloc(this.repository) : super(UpdateKamarInitial()) {
    on<SubmitUpdateKamar>(_onUpdateKamar);
  }

  void _onUpdateKamar(
    SubmitUpdateKamar event,
    Emitter<UpdateKamarState> emit,
  ) async {
    emit(UpdateKamarLoading());

    final result = await repository.updateKamar(event.request);

    result.fold(
      (error) {
        emit(UpdateKamarFailure(error));
      },
      (isSuccess) {
        if (isSuccess) {
          emit(UpdateKamarSuccess("Kamar berhasil diperbarui"));
        } else {
          emit(UpdateKamarFailure("Gagal memperbarui kamar"));
        }
      },
    );
  }
}
