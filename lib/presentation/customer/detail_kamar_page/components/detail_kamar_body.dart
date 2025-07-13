import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/customer/booking_page/screen/booking_screen.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/customer/detail_kamar_page/bloc/detail_kamar_bloc.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/customer/detail_kamar_page/components/detail_kamar_footer.dart';

class DetailKamarBody extends StatelessWidget {
  final int idHotel;

  const DetailKamarBody({super.key, required this.idHotel});

  @override
  Widget build(BuildContext context) {
    final currencyFormatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return BlocBuilder<DetailKamarBloc, DetailKamarState>(
      builder: (context, state) {
        if (state is KamarLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is KamarFailure) {
          return Center(child: Text("❌ ${state.message}"));
        }
        if (state is KamarSuccess) {
          final kamars = state.kamars;

          if (kamars.isEmpty) {
            return const Center(child: Text("Tidak ada kamar ditemukan."));
          }

          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.only(bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Judul
                  const Padding(
                    padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                    child: Text(
                      "Pilih Kamar Sesuai Kebutuhanmu",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  // List Kamar
                  SizedBox(
                    height: 260,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: kamars.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 16),
                      itemBuilder: (context, index) {
                        final kamar = kamars[index];
                        return GestureDetector(
                          onTap: () {
                            if (kamar.id != null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (_) => BookingScreen(
                                        idKamar: kamar.id!,
                                        namaKamar: kamar.namaKamar ?? '-',
                                        harga: kamar.harga ?? 0,
                                        deskripsiKamar:
                                            kamar.deskripsiKamar ?? '-',
                                      ),
                                ),
                              );
                            }
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 7,
                            shadowColor: Colors.black26,
                            child: SizedBox(
                              width: 200,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(12),
                                    ),
                                    child: Container(
                                      height: 150,
                                      color: const Color.fromARGB(
                                        255,
                                        216,
                                        214,
                                        214,
                                      ),
                                      child: const Center(
                                        child: Icon(
                                          Icons.bed,
                                          size: 40,
                                          color: Colors.blueAccent,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          kamar.namaKamar ?? '-',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          currencyFormatter.format(
                                            kamar.harga ?? 0,
                                          ),
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Color.fromARGB(
                                              255,
                                              222,
                                              86,
                                              76,
                                            ),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.inventory_2_outlined,
                                              size: 14,
                                              color: Colors.grey,
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              "Stok: ${kamar.stokKamar ?? 0}",
                                              style: const TextStyle(
                                                fontSize: 13,
                                                color: Colors.grey,
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

                  const SizedBox(height: 15),
                  // PROMO SECTION
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "Metode Pembayaran",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 75, // ← Ukuran keseluruhan diperkecil
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      itemCount: 4,
                      separatorBuilder:
                          (_, __) =>
                              const SizedBox(width: 12), // jarak antar card
                      itemBuilder: (context, index) {
                        final ewalletImages = [
                          "assets/images/linkaja.jpg",
                          "assets/images/gopay.jpg",
                          "assets/images/dana.jpg",
                          "assets/images/shopepay.jpg",
                        ];
                        return Card(
                          elevation: 5,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: SizedBox(
                            width: 75,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 6,
                                horizontal: 4,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    ewalletImages[index],
                                    width: 50,
                                    height: 50,
                                  ),
                                  const SizedBox(height: 4),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  const DetailKamarFooter(),
                ],
              ),
            ),
          );
        }
        return const Center(child: Text("Memuat kamar..."));
      },
    );
  }
}
