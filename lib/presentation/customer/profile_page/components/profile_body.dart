import 'package:flutter/material.dart';
import 'package:project_akhir_pam_lanjut_115/core/constants/colors.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/customer/riwayat_page/screen/riwayat_booking_screen.dart';

class ProfileBody extends StatelessWidget {
  final String? nama;
  final String? email;
  final String? role;
  final String? imageUrl;

  const ProfileBody({
    super.key,
    required this.nama,
    required this.email,
    required this.role,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '👤 Informasi Pengguna',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 10),
              _buildDivider(),
              _buildInfoTile(Icons.badge, "Nama", nama),
              _buildDivider(),
              _buildInfoTile(Icons.email, "Email", email),
              _buildDivider(),
              _buildInfoTile(
                Icons.history,
                "Riwayat",
                "Lihat riwayat booking",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const RiwayatBookingScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoTile(
    IconData icon,
    String title,
    String? subtitle, {
    VoidCallback? onTap,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: AppColors.primary),
      title: Text(title),
      subtitle: Text(subtitle ?? "-"),
      trailing:
          onTap != null ? const Icon(Icons.arrow_forward_ios, size: 16) : null,
      onTap: onTap,
    );
  }

  Widget _buildDivider() => const Divider(thickness: 1, height: 24);
}
