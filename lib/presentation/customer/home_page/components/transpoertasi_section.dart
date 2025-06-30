import 'package:flutter/material.dart';

class TranspoertasiSection extends StatelessWidget {
  const TranspoertasiSection({super.key});

  @override
  Widget build(BuildContext context) {
    final ewalletImages = [
      'assets/images/travel1.jpg',
      'assets/images/kapal.jpg',
      'assets/images/pesawat1.jpg',
      'assets/images/kereta1.jpg',
    ];
    final ewalletNames = ['TRAVEL', 'KAPAL', 'PESAWAT', 'KERETA'];

    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 10),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color.fromARGB(255, 236, 239, 250),
              Color.fromARGB(255, 221, 228, 252),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              // ignore: deprecated_member_use
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Transportasi, cari E-Tikkets mudah di sini!",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF333333),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 100,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: ewalletImages.length,
                separatorBuilder: (context, _) => const SizedBox(width: 16),
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        height: 70,
                        width: 72,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              // ignore: deprecated_member_use
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Image.asset(
                          ewalletImages[index],
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        ewalletNames[index],
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF444444),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
