import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/admin/data_boking_page/screen/data_booking_screen.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/admin/home_page_admin/screen/home_screen_admin.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/admin/bloc/get_hotel/get_hotel_bloc.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/admin/profile_admin_page/components/profile_admin_body.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/admin/profile_admin_page/components/profile_admin_footer.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/admin/profile_admin_page/components/profile_admin_header.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/customer/profile_page/bloc/get_profile_bloc.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/customer/profile_page/bloc/get_profile_event.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/customer/profile_page/bloc/get_profile_state.dart';

class ProfileAdminScreen extends StatefulWidget {
  const ProfileAdminScreen({super.key});

  @override
  State<ProfileAdminScreen> createState() => _ProfileAdminScreenState();
}

class _ProfileAdminScreenState extends State<ProfileAdminScreen> {
  int _selectedIndex = 2;

  @override
  void initState() {
    super.initState();
    // Memuat data profile
    context.read<GetProfileBloc>().add(LoadProfileEvent());
    // Memuat data hotel
    context.read<GetHotelBloc>().add(FetchUserHotels());
  }

  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreenAdmin()),
      );
    } else if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const DataBookingScreen()),
      );
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      body: BlocBuilder<GetProfileBloc, GetProfileState>(
        builder: (context, profileState) {
          if (profileState is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (profileState is ProfileLoaded) {
            final user = profileState.profile;

            return BlocBuilder<GetHotelBloc, GetHotelState>(
              builder: (context, hotelState) {
                if (hotelState is GetHotelLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (hotelState is GetHotelLoaded) {
                  final hotelList = hotelState.data.data;

                  if (hotelList == null || hotelList.isEmpty) {
                    return const Center(child: Text("Tidak ada data hotel"));
                  }

                  final hotelItem = hotelList.first;

                  return Column(
                    children: [
                      ProfileAdminHeader(nama: user.nama, email: user.email),
                      Expanded(
                        child: ProfileAdminBody(
                          nama: user.nama,
                          email: user.email,
                          role: user.role,
                          namaHotel: hotelItem.namaHotel,
                          deskripsiHotel: hotelItem.deskripsiHotel,
                          alamatHotel: hotelItem.alamat,
                        ),
                      ),
                    ],
                  );
                } else if (hotelState is GetHotelError) {
                  return Center(
                    child: Text('Error Hotel: ${hotelState.message}'),
                  );
                }
                return const SizedBox();
              },
            );
          } else if (profileState is ProfileError) {
            return Center(child: Text('❌ ${profileState.message}'));
          }
          return const Center(child: Text('Belum ada data'));
        },
      ),
      bottomNavigationBar: ProfileAdminFooter(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
