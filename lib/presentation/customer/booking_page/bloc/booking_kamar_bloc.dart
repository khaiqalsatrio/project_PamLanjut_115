import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_akhir_pam_lanjut_115/data/model/request/customer/booking_kamar_request_model.dart';
import 'package:project_akhir_pam_lanjut_115/data/model/response/customer/booking_kamar_response_model.dart';
import 'package:project_akhir_pam_lanjut_115/data/repository/customer_repository.dart';

part 'booking_kamar_event.dart';
part 'booking_kamar_state.dart';

class BookingKamarBloc extends Bloc<BookingKamarEvent, BookingKamarState> {
  final CustomerRepository repository;

  BookingKamarBloc(this.repository) : super(BookingKamarInitial()) {
    on<SubmitBookingKamar>((event, emit) async {
      emit(BookingKamarLoading());

      final result = await repository.bookingKamar(event.request);

      result.fold(
        (error) => emit(BookingKamarFailure(error)),
        (response) => emit(BookingKamarSuccess(response)),
      );
    });
  }
}
