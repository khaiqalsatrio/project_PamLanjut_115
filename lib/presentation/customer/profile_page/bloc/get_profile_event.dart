abstract class GetProfileEvent {}

class LoadProfileEvent extends GetProfileEvent {}

class UploadProfileImageEvent extends GetProfileEvent {
  final String filePath;
  UploadProfileImageEvent(this.filePath);
}
