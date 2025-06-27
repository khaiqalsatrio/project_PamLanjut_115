import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/customer/detail_kamar_page/bloc/detail_kamar_bloc.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/customer/detail_kamar_page/components/detail_kamar_body.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/customer/detail_kamar_page/components/detail_kamar_header.dart';

class DetailKamarScreen extends StatefulWidget {
  final int idHotel;
  final String hotelName;
  final String alamat;

  const DetailKamarScreen({
    super.key,
    required this.idHotel,
    required this.hotelName,
    required this.alamat,
  }); // 👈 Tambahan required hotelName

  @override
  State<DetailKamarScreen> createState() => _DetailKamarScreenState();
}

class _DetailKamarScreenState extends State<DetailKamarScreen> {
  @override
  void initState() {
    super.initState();
    context.read<DetailKamarBloc>().add(
      GetKamarByHotelEvent(idHotel: widget.idHotel),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          DetailKamarHeader(
            hotelName: widget.hotelName,
            alamat: widget.alamat,
          ), // 👈 Sekarang kirim hotelName
          Expanded(child: DetailKamarBody(idHotel: widget.idHotel)),
        ],
      ),
    );
  }
}
