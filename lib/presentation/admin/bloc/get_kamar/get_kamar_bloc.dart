import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_akhir_pam_lanjut_115/data/repository/admin_repository.dart';
import 'get_kamar_event.dart';
import 'get_kamar_state.dart';

class GetKamarBloc extends Bloc<GetKamarEvent, GetKamarState> {
  final AdminRepository repository;

  GetKamarBloc(this.repository) : super(GetKamarInitial()) {
    on<GetKamarFetchEvent>((event, emit) async {
      emit(GetKamarLoading());

      final result = await repository.getKamar();
      result.fold(
        (error) => emit(GetKamarFailure(error)),
        (data) => emit(GetKamarSuccess(data)),
      );
    });
  }
}
