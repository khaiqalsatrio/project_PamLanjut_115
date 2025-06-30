import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/customer/detail_kamar_page/screen/detail_kamar_screen.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/customer/get_all_hotel/bloc/get_all_hotel_bloc.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/customer/home_page/components/transpoertasi_section.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/customer/home_page/components/promo_section.dart';

class HomeCustomerBody extends StatelessWidget {
  const HomeCustomerBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "Rekomendasi Hotel",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
                letterSpacing: 0.5,
              ),
            ),
          ),
          const SizedBox(height: 0),

          // HANYA bagian hotel yang menggunakan BlocBuilder
          BlocBuilder<GetAllHotelBloc, GetAllHotelState>(
            builder: (context, state) {
              if (state is GetAllHotelLoading) {
                return SizedBox(
                  height: 250, // Tetap jaga tinggi
                  child: const Center(child: CircularProgressIndicator()),
                );
              }

              if (state is GetAllHotelFailure) {
                return SizedBox(
                  height: 250,
                  child: Center(child: Text(state.message)),
                );
              }

              if (state is GetAllHotelSuccess) {
                final hotels = state.hotels;
                if (hotels.isEmpty) {
                  return const SizedBox(
                    height: 250,
                    child: Center(child: Text("Tidak ada hotel ditemukan.")),
                  );
                }

                return SizedBox(
                  height: 250,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: hotels.length,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    separatorBuilder: (_, __) => const SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      final hotel = hotels[index];
                      return SizedBox(
                        width: 200,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 3,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(10),
                            onTap: () {
                              if (hotel.id != null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (_) => DetailKamarScreen(
                                          idHotel: hotel.id!,
                                          hotelName: hotel.namaHotel ?? '-',
                                          alamat: hotel.alamat ?? '-',
                                        ),
                                  ),
                                );
                              }
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(10),
                                  ),
                                  child: Container(
                                    height: 125,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      image: const DecorationImage(
                                        image: AssetImage(
                                          "assets/images/hotel_placeholder.jpg",
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          hotel.namaHotel ??
                                              'Nama hotel tidak tersedia',
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          hotel.deskripsiHotel ??
                                              'Deskripsi belum diisi',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 13,
                                            color: Colors.black54,
                                          ),
                                        ),
                                        const Spacer(),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.location_on,
                                              size: 14,
                                              color: Colors.blue,
                                            ),
                                            const SizedBox(width: 4),
                                            Expanded(
                                              child: Text(
                                                hotel.alamat ??
                                                    'Alamat tidak tersedia',
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black54,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }

              return const SizedBox(
                height: 250,
              ); // fallback height agar tidak naik
            },
          ),

          const SizedBox(height: 10),
          const TranspoertasiSection(),
          const PromoSection(),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
