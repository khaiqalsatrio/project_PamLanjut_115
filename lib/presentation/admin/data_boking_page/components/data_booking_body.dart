import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../bloc/get_booking_by_hotel_bloc.dart';
import '../bloc/get_booking_by_hotel_event.dart';
import '../bloc/get_booking_by_hotel_state.dart';

class DataBookingBody extends StatelessWidget {
  const DataBookingBody({super.key});

  String formatDate(DateTime? date) {
    if (date == null) return '-';
    return DateFormat('dd MMM yyyy', 'id_ID').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GetBookingByHotelBloc, GetBookingByHotelState>(
      listener: (context, state) {
        if (state is ConfirmBookingSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.green,
            ),
          );
        } else if (state is ConfirmBookingError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error), backgroundColor: Colors.red),
          );
        }
      },
      child: Expanded(
        child: BlocBuilder<GetBookingByHotelBloc, GetBookingByHotelState>(
          builder: (context, state) {
            if (state is GetBookingByHotelLoading ||
                state is ConfirmBookingLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is GetBookingByHotelError) {
              return Center(child: Text('Error: ${state.message}'));
            } else if (state is GetBookingByHotelLoaded) {
              if (state.bookings.isEmpty) {
                return const Center(child: Text('Belum ada booking'));
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: state.bookings.length,
                itemBuilder: (context, index) {
                  final booking = state.bookings[index];
                  final status = booking.status ?? '-';
                  final statusColor =
                      status == 'approved'
                          ? Colors.green
                          : status == 'pending'
                          ? Colors.orange
                          : Colors.red;

                  return Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.hotel,
                                size: 40,
                                color: Colors.teal,
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      booking.namaKamar ?? '-',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    Text(
                                      booking.namaHotel ?? '-',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.black54,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "${booking.namaUser ?? '-'} (${booking.emailUser ?? '-'})",
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.black45,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.calendar_today,
                                          size: 14,
                                          color: Colors.teal,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          "${formatDate(booking.checkInDate)} → ${formatDate(booking.checkOutDate)}",
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.teal,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  // ignore: deprecated_member_use
                                  color: statusColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  status.toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: statusColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          if (status == 'pending') ...[
                            const SizedBox(height: 12),
                            Align(
                              alignment: Alignment.centerRight,
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  context.read<GetBookingByHotelBloc>().add(
                                    ConfirmBookingRequested(booking.id!),
                                  );
                                },
                                icon: const Icon(Icons.check),
                                label: const Text("Konfirmasi Booking"),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 8,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                },
              );
            }

            return const Center(child: Text('Data Pesanan'));
          },
        ),
      ),
    );
  }
}
