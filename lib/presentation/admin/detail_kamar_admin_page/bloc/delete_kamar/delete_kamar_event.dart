// delete_kamar_event.dart
part of 'delete_kamar_bloc.dart';

abstract class DeleteKamarEvent {}

class DeleteKamar extends DeleteKamarEvent {
  final int idKamar;

  DeleteKamar(this.idKamar);
}
