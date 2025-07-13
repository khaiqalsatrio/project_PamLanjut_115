import 'package:flutter/material.dart';

class ProfileAdminFooter extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  const ProfileAdminFooter({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Color(0xFF8BA2E7),
      unselectedItemColor: Colors.white,
      currentIndex: selectedIndex,
      onTap: onItemTapped,
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
