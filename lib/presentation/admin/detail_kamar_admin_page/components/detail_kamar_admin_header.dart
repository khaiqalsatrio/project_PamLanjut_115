import 'package:flutter/material.dart';

class DetailKamarAdminHeader extends StatelessWidget
    implements PreferredSizeWidget {
  const DetailKamarAdminHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Detail Kamar'),
      backgroundColor: const Color(0xFF8BA2E7),
      foregroundColor: Colors.white,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
