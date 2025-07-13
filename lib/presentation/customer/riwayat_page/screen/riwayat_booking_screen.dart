import 'package:flutter/material.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/customer/riwayat_page/components/riwayat_booking_body.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/customer/riwayat_page/components/riwayat_booking_footer.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/customer/riwayat_page/components/riwayat_booking_header.dart';

class RiwayatBookingScreen extends StatelessWidget {
  const RiwayatBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: const RiwayatBookingHeader(),
      body: Column(
        children: const [
          Expanded(child: RiwayatBookingBody()),
          RiwayatBookingFooter(), // bisa dihilangkan jika belum perlu
        ],
      ),
    );
  }
}
