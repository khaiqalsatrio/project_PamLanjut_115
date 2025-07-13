part of 'add_kamar_bloc.dart';

abstract class AddKamarState {}

class AddKamarInitial extends AddKamarState {}

class AddKamarLoading extends AddKamarState {}

class AddKamarSuccess extends AddKamarState {}

class AddKamarFailure extends AddKamarState {
  final String error;

  AddKamarFailure(this.error);
}
