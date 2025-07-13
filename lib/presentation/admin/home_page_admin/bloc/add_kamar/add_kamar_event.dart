part of 'add_kamar_bloc.dart';

abstract class AddKamarEvent {}

class SubmitAddKamar extends AddKamarEvent {
  final AddKamarRequestModel request;

  SubmitAddKamar(this.request);
}
