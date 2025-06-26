import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/customer/detail_kamar_page/screen/detail_kamar_screen.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/customer/get_all_hotel/bloc/hotel_list_bloc.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/customer/home_page/components/ewallet_section.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/customer/home_page/components/promo_section.dart';

class HomeCustomerBody extends StatelessWidget {
  const HomeCustomerBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 90,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 139, 162, 231),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(28),
                    bottomRight: Radius.circular(28),
                  ),
                ),
              ),
              Positioned(
                left: 16,
                right: 16,
                top: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Harga terjangkau, lokasi strategis",
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                        hintText: "Cari hotel, lokasi...",
                        fillColor: Colors.white,
                        filled: true,
                        prefixIcon: const Icon(Icons.search),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: 16,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                SizedBox(width: 4, height: 20),
                Text(
                  "Rekomendasi Hotel",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
          ),
          BlocBuilder<HotelListBloc, HotelListState>(
            builder: (context, state) {
              if (state is HotelListLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is HotelListFailure) {
                return Center(child: Text("❌ ${state.message}"));
              }
              if (state is HotelListSuccess) {
                final hotels = state.hotels;
                if (hotels.isEmpty) {
                  return const Center(
                    child: Text("Tidak ada hotel ditemukan."),
                  );
                }

                return Column(
                  children: [
                    SizedBox(
                      height: 270,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: hotels.length,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 12,
                        ),
                        separatorBuilder: (_, __) => const SizedBox(width: 12),
                        itemBuilder: (context, index) {
                          final hotel = hotels[index];
                          return SizedBox(
                            width: 200,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 8,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(8),
                                onTap: () {
                                  if (hotel.id != null) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (_) => DetailKamarScreen(
                                              idHotel: hotel.id!,
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
                                        top: Radius.circular(8),
                                      ),
                                      child: Container(
                                        height: 130,
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
                                    Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            hotel.namaHotel ??
                                                'Nama hotel tidak tersedia',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black87,
                                            ),
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
                                          const SizedBox(height: 8),
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
                                                  'Alamat tidak tersedia',
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black54,
                                                  ),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    // EWALLET SECTION
                    EWalletSection(),

                    const SizedBox(height: 5),

                    // EWALLET SECTION
                    PromoSection(),
                  ],
                );
              }
              return const Center(child: Text("Silakan pilih hotel."));
            },
          ),
        ],
      ),
    );
  }
}
