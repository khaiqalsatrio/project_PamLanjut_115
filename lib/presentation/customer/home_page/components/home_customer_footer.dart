import 'package:flutter/material.dart';
import 'package:project_akhir_pam_lanjut_115/core/constants/colors.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/customer/detail_booking_page/screen/detail_booking_screen.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/customer/profile_page/screen/profile_screen.dart';

void handleNavigation(BuildContext context, int index) {
  if (index == 1) {
    int idBooking = 1;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => DetailBookingScreen(idBooking: idBooking),
      ),
    );
  } else if (index == 2) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const ProfileScreen()),
    );
  }
}

class HomeCustomerFooter extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  const HomeCustomerFooter({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: Colors.white,
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
