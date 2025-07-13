import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:project_akhir_pam_lanjut_115/data/repository/customer_repository.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/customer/riwayat_page/bloc/get_riwayat_booking_bloc.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/customer/riwayat_page/bloc/get_riwayat_booking_event.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/customer/riwayat_page/bloc/get_riwayat_booking_state.dart';

class RiwayatBookingBody extends StatelessWidget {
  const RiwayatBookingBody({super.key});

  String formatDate(DateTime? date) {
    if (date == null) return '-';
    return DateFormat('dd MMM yyyy', 'id_ID').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              GetRiwayatBookingBloc(context.read<CustomerRepository>())
                ..add(GetRiwayatBookingRequested()),
      child: BlocBuilder<GetRiwayatBookingBloc, GetRiwayatBookingState>(
        builder: (context, state) {
          if (state is GetRiwayatBookingLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetRiwayatBookingError) {
            return Center(child: Text('❌ ${state.message}'));
          } else if (state is GetRiwayatBookingLoaded) {
            if (state.data.isEmpty) {
              return const Center(child: Text('Tidak ada riwayat booking.'));
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.data.length,
              itemBuilder: (context, index) {
                final riwayat = state.data[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Card(
                    color: Colors.white,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.hotel, color: Colors.deepPurple),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  riwayat.namaHotel ?? '-',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  // ignore: deprecated_member_use
                                  color: Colors.green.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  riwayat.status?.toUpperCase() ?? '-',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: Colors.green,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            riwayat.namaKamar ?? '-',
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              const Icon(
                                Icons.calendar_today,
                                size: 16,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                "${formatDate(riwayat.checkInDate)} → ${formatDate(riwayat.checkOutDate)}",
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              const Icon(
                                Icons.monetization_on,
                                size: 16,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                'Rp ${riwayat.harga?.toStringAsFixed(0) ?? '0'}',
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return const Center(child: Text('Silakan muat data.'));
        },
      ),
    );
  }
}
