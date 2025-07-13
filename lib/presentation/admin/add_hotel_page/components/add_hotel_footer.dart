import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/admin/add_hotel_page/bloc/add_hotel_bloc.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/admin/add_hotel_page/bloc/add_hotel_state.dart';

class AddHotelFooter extends StatelessWidget {
  final VoidCallback onSavePressed;

  const AddHotelFooter({super.key, required this.onSavePressed});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AddHotelBloc>().state;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Tombol Simpan
          ElevatedButton.icon(
            icon:
                state is AddHotelLoading
                    ? const SizedBox(
                      height: 18,
                      width: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                    : const Icon(Icons.save),
            label: const Text(
              "Simpan Hotel",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
              backgroundColor: const Color.fromARGB(255, 139, 162, 231),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 3,
              shadowColor: Colors.black26,
            ),
            onPressed: state is AddHotelLoading ? null : onSavePressed,
          ),

          const SizedBox(height: 30),

          // Teks Info
          const Text(
            "Pastikan semua data hotel terisi lengkap agar informasi yang ditampilkan lebih akurat.",
            style: TextStyle(fontSize: 14, color: Colors.black54),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
