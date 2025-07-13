import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_akhir_pam_lanjut_115/data/model/request/admin/add_kamar_request_model.dart';
import 'package:project_akhir_pam_lanjut_115/data/repository/admin_repository.dart';

part 'add_kamar_event.dart';
part 'add_kamar_state.dart';

class AddKamarBloc extends Bloc<AddKamarEvent, AddKamarState> {
  final AdminRepository repository;

  AddKamarBloc(this.repository) : super(AddKamarInitial()) {
    on<SubmitAddKamar>(_onSubmitAddKamar);
  }

  void _onSubmitAddKamar(
    SubmitAddKamar event,
    Emitter<AddKamarState> emit,
  ) async {
    emit(AddKamarLoading());

    final result = await repository.addKamar(event.request);
    result.fold((error) => emit(AddKamarFailure(error)), (success) {
      if (success) {
        emit(AddKamarSuccess());
      } else {
        emit(AddKamarFailure("Gagal menambahkan kamar"));
      }
    });
  }
}
