import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/admin/home_page_admin/bloc/add_kamar/add_kamar_bloc.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/admin/home_page_admin/bloc/get_kamar_bloc.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/admin/home_page_admin/bloc/get_kamar_event.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/admin/detail_kamar_admin_page/bloc/update_kamar/update_kamar_bloc.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/admin/home_page_admin/components/home_admin_body.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/admin/home_page_admin/components/home_admin_footer.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/admin/home_page_admin/components/home_admin_header.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/auth/login_page/screen/login_screen.dart';

class HomeScreenAdmin extends StatefulWidget {
  const HomeScreenAdmin({super.key});

  @override
  State<HomeScreenAdmin> createState() => _HomeScreenAdminState();
}

class _HomeScreenAdminState extends State<HomeScreenAdmin> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    HomeAdminBody(),
    Center(child: Text("Data Booking Page")),
    Center(child: Text("Profile Hotel Page")),
  ];

  void _onLogout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    context.read<GetKamarBloc>().add(GetKamarFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AddKamarBloc, AddKamarState>(
          listener: (context, state) {
            if (state is AddKamarSuccess) {
              context.read<GetKamarBloc>().add(GetKamarFetchEvent());
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Kamar berhasil ditambahkan!')),
              );
            } else if (state is AddKamarFailure) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('Error: ${state.error}')));
            }
          },
        ),
        BlocListener<UpdateKamarBloc, UpdateKamarState>(
          listener: (context, state) {
            if (state is UpdateKamarSuccess) {
              context.read<GetKamarBloc>().add(GetKamarFetchEvent());
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            } else if (state is UpdateKamarFailure) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('Error: ${state.error}')));
            }
          },
        ),
      ],
      child: Scaffold(
        appBar:
            _selectedIndex == 0 ? HomeAdminHeader(onLogout: _onLogout) : null,
        body: _pages[_selectedIndex],
        bottomNavigationBar: HomeAdminFooter(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
