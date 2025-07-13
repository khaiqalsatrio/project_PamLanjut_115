import 'package:flutter/material.dart';

class RiwayatBookingHeader extends StatelessWidget
    implements PreferredSizeWidget {
  const RiwayatBookingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 139, 162, 231),
      foregroundColor: Colors.white,
      title: const Text('Riwayat Booking'),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
