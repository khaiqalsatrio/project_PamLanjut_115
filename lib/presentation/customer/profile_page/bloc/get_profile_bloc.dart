import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_akhir_pam_lanjut_115/data/repository/auth_repository.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/customer/profile_page/bloc/get_profile_event.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/customer/profile_page/bloc/get_profile_state.dart';

class GetProfileBloc extends Bloc<GetProfileEvent, GetProfileState> {
  final AuthRepository authRepository;

  GetProfileBloc(this.authRepository) : super(ProfileInitial()) {
    on<LoadProfileEvent>((event, emit) async {
      emit(ProfileLoading());
      final result = await authRepository.getProfile();
      result.fold((error) => emit(ProfileError(error)), (profileResponse) {
        final profile = profileResponse.user!;
        emit(ProfileLoaded(profile));
      });
    });
  }
}
