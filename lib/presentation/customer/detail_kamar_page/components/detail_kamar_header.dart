import 'package:flutter/material.dart';

class DetailKamarHeader extends StatelessWidget {
  final String hotelName;
  final String alamat;

  const DetailKamarHeader({
    super.key,
    required this.hotelName,
    required this.alamat,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background
        Container(
          height: 125,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 139, 162, 231),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
          ),
        ),
        // Konten
        Positioned(
          top: 50,
          left: 10,
          right: 10, // agar judul & alamat bisa memanfaatkan lebar penuh
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Tombol Back
              InkWell(
                onTap: () => Navigator.pop(context),
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.arrow_back, color: Colors.blue),
                ),
              ),
              const SizedBox(width: 12),
              // Hotel Name + Alamat
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Nama Hotel
                    Text(
                      hotelName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    // Alamat Hotel
                    Text(
                      alamat,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
