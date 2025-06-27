import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_akhir_pam_lanjut_115/data/model/response/customer/get_booking_response_model.dart';
import 'package:project_akhir_pam_lanjut_115/data/repository/customer_repository.dart';

part 'booking_detail_event.dart';
part 'booking_detail_state.dart';

class BookingDetailBloc extends Bloc<BookingDetailEvent, BookingDetailState> {
  final CustomerRepository repository;

  BookingDetailBloc(this.repository) : super(BookingDetailInitial()) {
    on<GetDetailBookingEvent>((event, emit) async {
      emit(BookingDetailLoading());

      final result = await repository.getBooking(event.idBooking);

      result.fold(
        (err) => emit(BookingDetailFailure(err)),
        (data) => emit(BookingDetailSuccess(data.data)),
      );
    });
  }
}
