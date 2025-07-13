import 'package:flutter/material.dart';

class DetailHotelFooter extends StatelessWidget {
  const DetailHotelFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: const Text(
        '📝 Data hotel ditampilkan berdasarkan akun admin login.',
        style: TextStyle(color: Colors.grey),
      ),
    );
  }
}
