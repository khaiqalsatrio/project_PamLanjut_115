import 'package:flutter/material.dart';

class AddHotelHeader extends StatelessWidget implements PreferredSizeWidget {
  const AddHotelHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("Lengkapi Data Hotel"),
      centerTitle: true,
      backgroundColor: const Color.fromARGB(255, 139, 162, 231),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
