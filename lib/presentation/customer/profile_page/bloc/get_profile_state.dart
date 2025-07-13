import 'package:project_akhir_pam_lanjut_115/data/model/response/auth/auth_response_model.dart';

abstract class GetProfileState {}

class ProfileInitial extends GetProfileState {}

class ProfileLoading extends GetProfileState {}

class ProfileLoaded extends GetProfileState {
  final User profile;
  ProfileLoaded(this.profile);
}

class ProfileError extends GetProfileState {
  final String message;
  ProfileError(this.message);
}

// Tambahan baru:
class ProfileUploading extends GetProfileState {}

class ProfileUploadSuccess extends GetProfileState {
  final String imageUrl;
  ProfileUploadSuccess(this.imageUrl);
}

class ProfileUploadFailure extends GetProfileState {
  final String message;
  ProfileUploadFailure(this.message);
}
