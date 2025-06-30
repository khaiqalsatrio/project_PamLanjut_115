import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookingBody extends StatelessWidget {
  final String namaKamar;
  final int harga;
  final String deskripsiKamar;

  const BookingBody({
    super.key,
    required this.namaKamar,
    required this.harga,
    required this.deskripsiKamar,
  });

  @override
  Widget build(BuildContext context) {
    final currencyFormatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        color: const Color.fromARGB(255, 236, 234, 234),
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        shadowColor: Colors.black12,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Nama Kamar
              Row(
                children: [
                  const Icon(Icons.bed, color: Colors.blueAccent),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      namaKamar,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Deskripsi
              Text(
                deskripsiKamar,
                style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
              ),
              const SizedBox(height: 16),

              // Harga
              Row(
                children: [
                  const SizedBox(width: 8),
                  Text(
                    "${currencyFormatter.format(harga)} / malam",
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.green,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
