import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:project_akhir_pam_lanjut_115/core/constants/colors.dart';

class DetailHotelBody extends StatelessWidget {
  final File? selectedImage;
  final Uint8List? imageBytes;
  final bool isUploading;
  final VoidCallback onUpload;
  final VoidCallback onPickImage;
  final String nama;
  final String deskripsi;
  final String alamat;

  const DetailHotelBody({
    super.key,
    required this.selectedImage,
    required this.imageBytes,
    required this.isUploading,
    required this.onUpload,
    required this.onPickImage,
    required this.nama,
    required this.deskripsi,
    required this.alamat,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Gambar Hotel
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child:
                    selectedImage != null
                        ? Image.file(
                          selectedImage!,
                          width: double.infinity,
                          height: 200,
                          fit: BoxFit.cover,
                        )
                        : imageBytes != null
                        ? Image.memory(
                          imageBytes!,
                          width: double.infinity,
                          height: 200,
                          fit: BoxFit.cover,
                        )
                        : GestureDetector(
                          onTap: onPickImage,
                          child: Container(
                            width: double.infinity,
                            height: 200,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Center(
                              child: Text("📷 Tambahkan Gambar Hotel"),
                            ),
                          ),
                        ),
              ),
              const SizedBox(height: 16),
              // Tombol Ganti Gambar
              ElevatedButton.icon(
                onPressed: onPickImage,
                icon: const Icon(Icons.photo_library),
                label: const Text("Update Gambar"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                ),
              ),
              const SizedBox(height: 10),
              // Tombol Upload (jika ada selectedImage)
              if (selectedImage != null && !isUploading)
                ElevatedButton.icon(
                  onPressed: onUpload,
                  icon: const Icon(Icons.upload),
                  label: const Text("Upload Gambar"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                  ),
                ),
              if (isUploading) const Center(child: CircularProgressIndicator()),
              const Divider(height: 32),
              Text("🏨 Nama Hotel", style: _titleStyle),
              const SizedBox(height: 4),
              Text(nama, style: _contentStyle),
              const Divider(height: 24),
              Text("📝 Deskripsi", style: _titleStyle),
              const SizedBox(height: 4),
              Text(deskripsi, style: _contentStyle),
              const Divider(height: 24),
              Text("📍 Alamat", style: _titleStyle),
              const SizedBox(height: 4),
              Text(alamat, style: _contentStyle),
            ],
          ),
        ),
      ),
    );
  }

  TextStyle get _titleStyle => const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
  );

  TextStyle get _contentStyle =>
      const TextStyle(fontSize: 15, color: Colors.black87);
}
