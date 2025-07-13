import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/admin/data_boking_page/bloc/get_booking_by_hotel_bloc.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/admin/data_boking_page/bloc/get_booking_by_hotel_event.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/admin/data_boking_page/components/data_booking_body.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/admin/data_boking_page/components/data_booking_footer.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/admin/data_boking_page/components/data_booking_header.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/admin/home_page_admin/screen/home_screen_admin.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/admin/profile_admin_page/screen/profile_admin_screen.dart';

class DataBookingScreen extends StatefulWidget {
  const DataBookingScreen({super.key});

  @override
  State<DataBookingScreen> createState() => _DataBookingScreenState();
}

class _DataBookingScreenState extends State<DataBookingScreen> {
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreenAdmin()),
      );
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ProfileAdminScreen()),
      );
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    context.read<GetBookingByHotelBloc>().add(GetBookingByHotelRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      body: Column(children: const [DataBookingHeader(), DataBookingBody()]),
      bottomNavigationBar: DataBookingFooter(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
