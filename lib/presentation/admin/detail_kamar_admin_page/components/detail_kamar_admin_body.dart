import 'package:flutter/material.dart';

class DetailKamarAdminBody extends StatelessWidget {
  final TextEditingController namaController;
  final TextEditingController stokController;
  final TextEditingController hargaController;
  final TextEditingController deskripsiController;
  final FocusNode namaFocusNode;

  const DetailKamarAdminBody({
    super.key,
    required this.namaController,
    required this.stokController,
    required this.hargaController,
    required this.deskripsiController,
    required this.namaFocusNode,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        TextFormField(
          focusNode: namaFocusNode,
          controller: namaController,
          decoration: InputDecoration(
            labelText: "Nama Kamar",
            prefixIcon: const Icon(Icons.king_bed_outlined),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xFF8BA2E7), width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: stokController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: "Stok Kamar",
            prefixIcon: const Icon(Icons.storage),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xFF8BA2E7), width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: hargaController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: "Harga",
            prefixIcon: const Icon(Icons.attach_money),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xFF8BA2E7), width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: deskripsiController,
          maxLines: 3,
          decoration: InputDecoration(
            labelText: "Deskripsi Kamar",
            prefixIcon: const Icon(Icons.description),
            alignLabelWithHint: true,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xFF8BA2E7), width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }
}
