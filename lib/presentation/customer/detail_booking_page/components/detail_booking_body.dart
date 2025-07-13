import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/customer/detail_booking_page/bloc/booking_detail_bloc.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/customer/riwayat_page/screen/riwayat_booking_screen.dart';

class DetailBookingBody extends StatelessWidget {
  DetailBookingBody({super.key});

  final currencyFormatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
  );
  Widget _buildInfoRow(
    IconData icon,
    String label,
    String value, {
    Color? valueColor,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, size: 18, color: Colors.grey),
            const SizedBox(width: 6),
            Text(label),
          ],
        ),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: valueColor ?? Colors.black87,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingDetailBloc, BookingDetailState>(
      builder: (context, state) {
        if (state is BookingDetailLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is BookingDetailFailure) {
          return Center(child: Text("❌ ${state.message}"));
        }
        if (state is BookingDetailSuccess) {
          final bookings = state.bookings;
          if (bookings.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Tidak ada order aktif.",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Semua e-tiket milikmu akan ditampilkan di",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const Text(
                    "sini Yuk, rencanakan perjalanan dengan",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const Text(
                    "InapGo.",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const RiwayatBookingScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'Riwayat Pesanan',
                      style: TextStyle(fontSize: 16, color: Colors.blue),
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: bookings.length,
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final booking = bookings[index];
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      // ignore: deprecated_member_use
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 233, 231, 231),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            booking.namaHotel,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 81, 80, 80),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(
                                Icons.bed_outlined,
                                color: Color.fromARGB(255, 81, 80, 80),
                                size: 18,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                booking.namaKamar,
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 81, 80, 80),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      child: const Divider(thickness: 1, color: Colors.grey),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildInfoRow(
                            Icons.date_range,
                            'Check-in',
                            booking.checkInDate?.toString() ?? '-',
                          ),
                          const SizedBox(height: 6),
                          _buildInfoRow(
                            Icons.logout,
                            'Check-out',
                            booking.checkOutDate?.toString() ?? '-',
                          ),
                          const SizedBox(height: 6),
                          _buildInfoRow(
                            Icons.attach_money,
                            'Harga',
                            currencyFormatter.format(booking.harga),
                          ),
                          const SizedBox(height: 6),
                          _buildInfoRow(
                            Icons.info_outline,
                            'Status',
                            booking.status,
                            valueColor:
                                booking.status == 'pending'
                                    ? const Color.fromARGB(255, 244, 164, 35)
                                    : booking.status == 'confirmed'
                                    ? Colors.green
                                    : Colors.red,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
        return const Center(child: Text("Memuat data..."));
      },
    );
  }
}
