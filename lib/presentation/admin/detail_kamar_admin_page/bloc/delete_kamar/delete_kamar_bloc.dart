import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_akhir_pam_lanjut_115/data/repository/admin_repository.dart';

part 'delete_kamar_event.dart';
part 'delete_kamar_state.dart';

class DeleteKamarBloc extends Bloc<DeleteKamarEvent, DeleteKamarState> {
  final AdminRepository repository;

  DeleteKamarBloc(this.repository) : super(DeleteKamarInitial()) {
    on<DeleteKamar>(_onDeleteKamar);
  }

  void _onDeleteKamar(DeleteKamar event, Emitter<DeleteKamarState> emit) async {
    emit(DeleteKamarLoading());

    final result = await repository.deleteKamar(event.idKamar);

    result.fold((error) => emit(DeleteKamarFailure(error)), (isSuccess) {
      if (isSuccess) {
        emit(DeleteKamarSuccess("Kamar berhasil dihapus"));
      } else {
        emit(DeleteKamarFailure("Gagal menghapus kamar"));
      }
    });
  }
}
