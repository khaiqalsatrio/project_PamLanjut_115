// delete_kamar_state.dart
part of 'delete_kamar_bloc.dart';

abstract class DeleteKamarState {}

class DeleteKamarInitial extends DeleteKamarState {}

class DeleteKamarLoading extends DeleteKamarState {}

class DeleteKamarSuccess extends DeleteKamarState {
  final String message;

  DeleteKamarSuccess(this.message);
}

class DeleteKamarFailure extends DeleteKamarState {
  final String error;

  DeleteKamarFailure(this.error);
}
