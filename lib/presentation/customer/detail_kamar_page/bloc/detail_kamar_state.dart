part of 'detail_kamar_bloc.dart';

abstract class DetailKamarState {}

class KamarInitial extends DetailKamarState {}

class KamarLoading extends DetailKamarState {}

class KamarSuccess extends DetailKamarState {
  final List<DataKamar> kamars;

  KamarSuccess(this.kamars);
}

class KamarFailure extends DetailKamarState {
  final String message;

  KamarFailure(this.message);
}
