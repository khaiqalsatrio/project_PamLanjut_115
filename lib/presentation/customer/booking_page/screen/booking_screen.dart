import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/customer/booking_page/bloc/booking_kamar_bloc.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/customer/booking_page/components/booking_body.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/customer/booking_page/components/booking_footer.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/customer/booking_page/components/booking_header.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/customer/profile_page/bloc/get_profile_bloc.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/customer/profile_page/bloc/get_profile_event.dart';

class BookingScreen extends StatefulWidget {
  final int idKamar;
  final String namaKamar;
  final int harga;
  final String deskripsiKamar;

  const BookingScreen({
    super.key,
    required this.idKamar,
    required this.namaKamar,
    required this.harga,
    required this.deskripsiKamar,
  });

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final _formKey = GlobalKey<FormState>();

  DateTime? selectedCheckinDate;
  DateTime? selectedCheckoutDate;

  final TextEditingController _checkinController = TextEditingController();
  final TextEditingController _checkoutController = TextEditingController();

  @override
  void dispose() {
    _checkinController.dispose();
    _checkoutController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    context.read<GetProfileBloc>().add(LoadProfileEvent());
  }

  Future<void> _selectDate({required bool isCheckin}) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      final formatted =
          "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      setState(() {
        if (isCheckin) {
          selectedCheckinDate = picked;
          _checkinController.text = formatted;
        } else {
          selectedCheckoutDate = picked;
          _checkoutController.text = formatted;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: BlocListener<BookingKamarBloc, BookingKamarState>(
        listener: (context, state) {
          if (state is BookingKamarSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.response.message ?? 'Berhasil')),
            );
            Navigator.pop(context);
          } else if (state is BookingKamarFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              const BookingHeader(),
              const SizedBox(height: 16),
              BookingBody(
                namaKamar: widget.namaKamar,
                harga: widget.harga,
                deskripsiKamar: widget.deskripsiKamar,
              ),
              BookingFooter(
                formKey: _formKey,
                checkinController: _checkinController,
                checkoutController: _checkoutController,
                onTapCheckin: () => _selectDate(isCheckin: true),
                onTapCheckout: () => _selectDate(isCheckin: false),
                checkinDate: selectedCheckinDate,
                checkoutDate: selectedCheckoutDate,
                idKamar: widget.idKamar,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
