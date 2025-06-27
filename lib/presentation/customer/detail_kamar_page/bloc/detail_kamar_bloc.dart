import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_akhir_pam_lanjut_115/data/model/request/customer/get_kamar_by_hotel_request_model.dart';
import 'package:project_akhir_pam_lanjut_115/data/model/response/customer/get_kamar_by_hotel_response_model.dart';
import 'package:project_akhir_pam_lanjut_115/data/repository/customer_repository.dart';

part 'detail_kamar_event.dart';
part 'detail_kamar_state.dart';

class DetailKamarBloc extends Bloc<DetailKamarEvent, DetailKamarState> {
  final CustomerRepository repository;

  DetailKamarBloc(this.repository) : super(KamarInitial()) {
    on<GetKamarByHotelEvent>((event, emit) async {
      emit(KamarLoading());

      final result = await repository.getKamarByHotel(
        GetKamarByHotelRequestModel(idHotel: event.idHotel),
      );

      result.fold(
        (err) => emit(KamarFailure(err)),
        (data) => emit(KamarSuccess(data.data ?? [])),
      );
    });
  }
}
