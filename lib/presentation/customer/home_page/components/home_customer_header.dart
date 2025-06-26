import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/auth/login_page/screen/login_screen.dart';

// ignore: non_constant_identifier_names
AppBar HomeCustomerHeader(BuildContext context) {
  return AppBar(
    backgroundColor: const Color.fromARGB(255, 139, 162, 231),
    foregroundColor: Colors.white,
    elevation: 0,
    title: Row(
      children: [
        const Icon(Icons.bed_outlined, size: 28, color: Colors.white),
        const SizedBox(width: 8),
        RichText(
          text: const TextSpan(
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            children: [
              TextSpan(text: 'Inap'),
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
      ],
    ),
    actions: [
      IconButton(
        icon: const Icon(Icons.logout, color: Colors.white),
        tooltip: 'Logout',
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return CupertinoAlertDialog(
                title: const Text("Konfirmasi"),
                content: const Text("Apakah Anda yakin ingin keluar?"),
                actions: [
                  CupertinoDialogAction(
                    child: const Text("Batal"),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  CupertinoDialogAction(
                    child: const Text("Keluar"),
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                        (route) => false,
                      );
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    ],
  );
}
