import 'package:flutter/material.dart';
import 'package:project_akhir_pam_lanjut_115/core/constants/colors.dart';

class ProfileBody extends StatelessWidget {
  final String? nama;
  final String? email;
  final String? role;

  const ProfileBody({
    super.key,
    required this.nama,
    required this.email,
    required this.role,
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
              _buildInfoTile(Icons.person, "Role", role),
              _buildDivider(),
              _buildInfoTile(Icons.history, "Riwayat", role),
              _buildDivider(),
              _buildInfoTile(Icons.delete, "Hapus Akun", role),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoTile(IconData icon, String title, String? subtitle) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: AppColors.primary),
      title: Text(title),
      subtitle: Text(subtitle ?? "-"),
    );
  }

  Widget _buildDivider() => const Divider(thickness: 1, height: 24);
}
