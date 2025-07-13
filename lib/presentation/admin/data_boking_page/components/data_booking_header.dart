import 'package:flutter/material.dart';

class DataBookingHeader extends StatelessWidget implements PreferredSizeWidget {
  const DataBookingHeader({super.key});

  @override
  Widget build(BuildContext context) {
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      height: 3,
                    ),
                    children: [
                      TextSpan(text: 'Data Booking'),
                      TextSpan(
                        text: ' Hotel',
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
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
