import 'package:flutter/material.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/admin/data_boking_page/screen/data_booking_screen.dart';

import 'package:project_akhir_pam_lanjut_115/presentation/admin/home_page_admin/screen/home_screen_admin.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/admin/profile_admin_page/screen/profile_admin_screen.dart';

class HomeAdminFooter extends StatelessWidget {
  const HomeAdminFooter({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Color(0xFF8BA2E7),
      unselectedItemColor: Colors.white,
      currentIndex: currentIndex,
      onTap: (index) {
        if (index == 0) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreenAdmin()),
          );
        } else if (index == 1) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const DataBookingScreen()),
          );
        } else if (index == 2) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const ProfileAdminScreen()),
          );
        }
        onTap(index);
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.book), label: "Data Booking"),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: "Profile Hotel",
        ),
      ],
    );
  }
}
