import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_akhir_pam_lanjut_115/presentation/auth/login_page/screen/login_screen.dart';

// ignore: non_constant_identifier_names
AppBar HomeCustomerHeader(
  BuildContext context, {
  required TextEditingController controller,
  required Function(String) onChanged,
}) {
  return AppBar(
    backgroundColor: const Color.fromARGB(255, 139, 162, 231),
    foregroundColor: Colors.white,
    elevation: 0,
    toolbarHeight: 140,
    automaticallyImplyLeading: false,
    flexibleSpace: Padding(
      padding: const EdgeInsets.only(top: 30, left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Branding & Logout
          Row(
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
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.logout, color: Colors.white),
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
                                MaterialPageRoute(
                                  builder: (_) => const LoginScreen(),
                                ),
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
          ),
          const Text(
            "Rencanakan perjalanan hemat dengan, InapGo",
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
          const SizedBox(height: 0),
          // TextField Pencarian
          TextField(
            controller: controller,
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: "Nama hotel, atau destinasi dll...",
              fillColor: Colors.white,
              filled: true,
              prefixIcon: const Icon(Icons.search),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 0,
                horizontal: 16,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
