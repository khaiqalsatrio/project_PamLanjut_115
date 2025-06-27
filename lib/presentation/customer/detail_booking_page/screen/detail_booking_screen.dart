import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/customer/detail_booking_page/bloc/booking_detail_bloc.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/customer/detail_booking_page/components/detail_booking_body.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/customer/detail_booking_page/components/detail_booking_footer.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/customer/detail_booking_page/components/detail_booking_header.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/customer/home_page/screen/home_screen_customer.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/customer/profile_page/screen/profile_screen.dart';

class DetailBookingScreen extends StatefulWidget {
  final int idBooking;

  const DetailBookingScreen({super.key, required this.idBooking});

  @override
  State<DetailBookingScreen> createState() => _DetailBookingScreenState();
}

class _DetailBookingScreenState extends State<DetailBookingScreen> {
  int _currentIndex = 1;

  @override
  void initState() {
    super.initState();
    context.read<BookingDetailBloc>().add(
      GetDetailBookingEvent(idBooking: widget.idBooking),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreenCustomer()),
      );
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const ProfileScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9),
      body: Column(
        children: [
          const DetailBookingHeader(),
          Expanded(child: DetailBookingBody()),
        ],
      ),
      bottomNavigationBar: DetailBookingFooter(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
