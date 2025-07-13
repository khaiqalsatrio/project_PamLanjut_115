import 'package:flutter/material.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/google_maps/map_result.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/google_maps/map_page.dart';

class AddHotelBody extends StatelessWidget {
  final TextEditingController namaController;
  final TextEditingController deskripsiController;
  final TextEditingController kotaController;
  final MapResult? selectedLocation;
  final ValueChanged<MapResult> onLocationSelected;

  const AddHotelBody({
    super.key,
    required this.namaController,
    required this.deskripsiController,
    required this.kotaController,
    required this.selectedLocation,
    required this.onLocationSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Field Nama Hotel
        TextField(
          controller: namaController,
          decoration: const InputDecoration(
            labelText: "Nama Hotel",
            border: OutlineInputBorder(),
            isDense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
        const SizedBox(height: 16),

        // Field Deskripsi Hotel
        TextField(
          controller: deskripsiController,
          maxLines: 3,
          decoration: const InputDecoration(
            labelText: "Deskripsi Hotel",
            border: OutlineInputBorder(),
            isDense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
        const SizedBox(height: 10),

        // Field Nama Kota
        TextField(
          controller: kotaController,
          decoration: const InputDecoration(
            labelText: "Kota",
            border: OutlineInputBorder(),
            isDense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),

        const SizedBox(height: 24),

        // Section Lokasi
        const Text(
          "Pilih Lokasi Hotel",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),

        // Kontainer Lokasi
        selectedLocation != null
            ? Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    offset: const Offset(0, 2),
                    blurRadius: 6,
                  ),
                ],
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Latitude: ${selectedLocation!.latitude}",
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Longitude: ${selectedLocation!.longitude}",
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Alamat: ${selectedLocation!.address}",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            )
            : Container(
              height: 180,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    offset: const Offset(0, 2),
                    blurRadius: 6,
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  "Peta Lokasi (Belum Dipilih)",
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
              ),
            ),

        const SizedBox(height: 16),

        // Button untuk Memilih Lokasi
        ElevatedButton.icon(
          icon: const Icon(Icons.map),
          label: const Text("Pilih Lokasi dengan Maps"),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: const Color.fromARGB(255, 139, 162, 231),
            foregroundColor: Colors.white,
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          onPressed: () async {
            final result = await Navigator.push<MapResult>(
              context,
              MaterialPageRoute(builder: (context) => const MapPage()),
            );
            if (result != null) {
              onLocationSelected(result);
            }
          },
        ),
      ],
    );
  }
}
