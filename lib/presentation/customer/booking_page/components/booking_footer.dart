import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_akhir_pam_lanjut_115/data/model/request/customer/booking_kamar_request_model.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/customer/booking_page/bloc/booking_kamar_bloc.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/customer/profile_page/bloc/get_profile_bloc.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/customer/profile_page/bloc/get_profile_state.dart';

class BookingFooter extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController checkinController;
  final TextEditingController checkoutController;
  final VoidCallback onTapCheckin;
  final VoidCallback onTapCheckout;
  final DateTime? checkinDate;
  final DateTime? checkoutDate;
  final int idKamar;

  const BookingFooter({
    super.key,
    required this.formKey,
    required this.checkinController,
    required this.checkoutController,
    required this.onTapCheckin,
    required this.onTapCheckout,
    required this.checkinDate,
    required this.checkoutDate,
    required this.idKamar,
  });

  Widget _buildDateField({
    required String label,
    required IconData icon,
    required TextEditingController controller,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.grey.withOpacity(0.15),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        readOnly: true,
        onTap: onTap,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.blue),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 18,
            horizontal: 16,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.blue, width: 1.5),
          ),
        ),
        validator:
            (value) =>
                value == null || value.isEmpty
                    ? '$label tidak boleh kosong'
                    : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingKamarBloc, BookingKamarState>(
      builder: (context, bookingState) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                /// 🔹 Card Informasi User
                BlocBuilder<GetProfileBloc, GetProfileState>(
                  builder: (context, profileState) {
                    if (profileState is ProfileLoading) {
                      return const Padding(
                        padding: EdgeInsets.only(bottom: 16),
                        child: CircularProgressIndicator(),
                      );
                    } else if (profileState is ProfileLoaded) {
                      final user = profileState.profile;
                      final String nama = user.nama ?? '-';
                      final String email = user.email ?? '-';
                      final bool isWanita = nama.toLowerCase().contains('ny');
                      final String sapaan = isWanita ? 'Ny.' : 'Tn.';
                      return Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: const EdgeInsets.only(bottom: 20),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.person_outline,
                                    color: Colors.blue,
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      '$sapaan $nama',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.email_outlined,
                                    color: Colors.blue,
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      email,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    } else if (profileState is ProfileError) {
                      return Text(
                        'Gagal memuat profil: ${profileState.message}',
                        style: const TextStyle(color: Colors.red),
                      );
                    }
                    return const SizedBox();
                  },
                ),
                _buildDateField(
                  label: 'Tanggal Check-In',
                  icon: Icons.calendar_today,
                  controller: checkinController,
                  onTap: onTapCheckin,
                ),
                const SizedBox(height: 16),
                _buildDateField(
                  label: 'Tanggal Check-Out',
                  icon: Icons.calendar_today_outlined,
                  controller: checkoutController,
                  onTap: onTapCheckout,
                ),
                const SizedBox(height: 24),
                bookingState is BookingKamarLoading
                    ? const CircularProgressIndicator()
                    : SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.hotel),
                        label: const Text('Booking Sekarang'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            final request = BookingKamarRequestModel(
                              idKamar: idKamar,
                              checkInDate: checkinDate,
                              checkOutDate: checkoutDate,
                            );
                            context.read<BookingKamarBloc>().add(
                              SubmitBookingKamar(request),
                            );
                          }
                        },
                      ),
                    ),
                const SizedBox(height: 30),
                const Text(
                  'Setelah melakukan booking, Anda tidak dapat membatalkannya.\n'
                  'Cek kembali kelengkapan data Anda!.',
                  style: TextStyle(
                    fontSize: 13,
                    color: Color.fromARGB(255, 18, 18, 18),
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        );
      },
    );
  }
}
