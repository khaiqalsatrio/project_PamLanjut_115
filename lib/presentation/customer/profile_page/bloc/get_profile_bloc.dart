import 'dart:io';
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
    on<UploadProfileImageEvent>((event, emit) async {
      emit(ProfileUploading());
      final uploadResult = await authRepository.uploadProfileImage(
        File(event.filePath),
      );
      uploadResult.fold((error) => emit(ProfileUploadFailure(error)), (
        imageUrl,
      ) async {
        emit(ProfileUploadSuccess(imageUrl));
        // Setelah berhasil upload, kita ambil ulang profil untuk update gambar
        add(LoadProfileEvent());
      });
    });
  }
}
