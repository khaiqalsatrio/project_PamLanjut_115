import 'package:flutter/material.dart';

class DetailBookingHeader extends StatelessWidget {
  const DetailBookingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      padding: const EdgeInsets.only(top: 40, left: 20),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 139, 162, 231),
      ),
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          SizedBox(height: 20),
          Text(
            "Detail Booking",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          Text(
            "Informasi lengkap mengenai booking anda",
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
