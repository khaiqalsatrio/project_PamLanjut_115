part of 'update_kamar_bloc.dart';

abstract class UpdateKamarEvent {}

class SubmitUpdateKamar extends UpdateKamarEvent {
  final UpdateKamarRequestModel request;

  SubmitUpdateKamar(this.request);
}
