import 'package:flutter/material.dart';
import 'package:project_akhir_pam_lanjut_115/core/constants/colors.dart';

class ProfileFooter extends StatelessWidget {
  final int currentIndex;
  final Function(int) onItemTapped;

  const ProfileFooter({
    super.key,
    required this.currentIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onItemTapped,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: const Color.fromARGB(255, 216, 216, 216),
      backgroundColor: const Color.fromARGB(255, 139, 162, 231),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.assignment), label: 'Pesanan'),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: 'Profil',
        ),
      ],
    );
  }
}
