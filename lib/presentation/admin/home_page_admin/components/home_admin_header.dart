import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/admin/bloc/get_hotel/get_hotel_bloc.dart';

class HomeAdminHeader extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onLogout;

  const HomeAdminHeader({super.key, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetHotelBloc, GetHotelState>(
      builder: (context, state) {
        return AppBar(
          toolbarHeight: preferredSize.height,
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: const SizedBox.shrink(),
          automaticallyImplyLeading: false,
          flexibleSpace: ClipRRect(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF8BA2E7), Color(0xFF8BA2E7)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 40, 16, 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          height: 1.5,
                        ),
                        children: [
                          TextSpan(text: 'Dashboard Admin Inap'),
                          TextSpan(
                            text: 'GO',
                            style: TextStyle(
                              color: Colors.amberAccent,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.logout, color: Colors.white),
                      tooltip: 'Logout',
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return CupertinoAlertDialog(
                              title: const Text("Konfirmasi"),
                              content: const Text(
                                "Apakah Anda yakin ingin keluar?",
                              ),
                              actions: [
                                CupertinoDialogAction(
                                  child: const Text("Batal"),
                                  onPressed: () => Navigator.of(context).pop(),
                                ),
                                CupertinoDialogAction(
                                  onPressed: onLogout,
                                  child: const Text("Keluar"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
