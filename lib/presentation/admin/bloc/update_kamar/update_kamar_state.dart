part of 'update_kamar_bloc.dart';

abstract class UpdateKamarState {}

class UpdateKamarInitial extends UpdateKamarState {}

class UpdateKamarLoading extends UpdateKamarState {}

class UpdateKamarSuccess extends UpdateKamarState {
  final String message;

  UpdateKamarSuccess(this.message);
}

class UpdateKamarFailure extends UpdateKamarState {
  final String error;

  UpdateKamarFailure(this.error);
}
