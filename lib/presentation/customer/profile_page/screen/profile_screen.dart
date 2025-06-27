import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/customer/detail_booking_page/screen/detail_booking_screen.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/customer/home_page/screen/home_screen_customer.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/customer/profile_page/bloc/get_profile_bloc.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/customer/profile_page/bloc/get_profile_event.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/customer/profile_page/bloc/get_profile_state.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/customer/profile_page/components/profile_body.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/customer/profile_page/components/profile_footer.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/customer/profile_page/components/profile_header.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final int _currentIndex = 2;

  @override
  void initState() {
    super.initState();
    context.read<GetProfileBloc>().add(LoadProfileEvent());
  }

  void _onItemTapped(int index) {
    if (index == _currentIndex) return;
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreenCustomer()),
      );
    } else if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const DetailBookingScreen(idBooking: 1),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      body: BlocBuilder<GetProfileBloc, GetProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProfileLoaded) {
            final user = state.profile;
            return Column(
              children: [
                ProfileHeader(nama: user.nama, email: user.email),
                Expanded(
                  child: ProfileBody(
                    nama: user.nama,
                    email: user.email,
                    role: user.role,
                  ),
                ),
              ],
            );
          } else if (state is ProfileError) {
            return Center(child: Text('❌ ${state.message}'));
          }
          return const Center(child: Text('Belum ada data'));
        },
      ),
      bottomNavigationBar: ProfileFooter(
        currentIndex: _currentIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
