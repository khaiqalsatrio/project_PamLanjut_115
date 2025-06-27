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
              padding: const EdgeInsets.only(bottom: 16),
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
                    height: 265,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: kamars.length,
                      separatorBuilder:
                          (_, __) =>
                              const SizedBox(width: 16), // Jarak antar kartu
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
                            elevation: 10,
                            shadowColor: Colors.black26,
                            child: SizedBox(
                              width: 200,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Gambar Placeholder
                                  ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(12),
                                    ),
                                    child: Container(
                                      height: 155,
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
                                  // Detail Kamar
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
                  const SizedBox(height: 12),
                  // PROMO SECTION
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "Promo Spesial",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 120,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: 2,
                      separatorBuilder: (_, __) => const SizedBox(width: 12),
                      itemBuilder: (context, index) {
                        final promoImages = [
                          "assets/images/diskon.jpg",
                          "assets/images/diskon.jpg",
                        ];
                        final promoTexts = [
                          "Diskon 50% untuk pengguna baru",
                          "Gratis Sarapan untuk semua booking",
                        ];
                        return Container(
                          width: 280,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image: AssetImage(promoImages[index]),
                              fit: BoxFit.cover,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 6,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                bottom: 10,
                                left: 10,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    // ignore: deprecated_member_use
                                    color: Colors.black.withOpacity(0.6),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    promoTexts[index],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
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
