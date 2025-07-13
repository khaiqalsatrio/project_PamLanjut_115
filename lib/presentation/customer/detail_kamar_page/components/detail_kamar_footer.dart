import 'package:flutter/material.dart';

class DetailKamarFooter extends StatelessWidget {
  const DetailKamarFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            "Fasilitas Penginapan",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Card(
            elevation: 7,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  ListTile(
                    leading: Icon(Icons.wifi, color: Colors.blue),
                    title: Text("WiFi Gratis"),
                  ),
                  Divider(height: 0),
                  ListTile(
                    leading: Icon(Icons.local_dining, color: Colors.deepOrange),
                    title: Text("Restoran & Kafe"),
                  ),
                  Divider(height: 0),
                  ListTile(
                    leading: Icon(Icons.local_parking, color: Colors.green),
                    title: Text("Parkir Gratis"),
                  ),
                  Divider(height: 0),
                  ListTile(
                    leading: Icon(Icons.pool, color: Colors.lightBlue),
                    title: Text("Kolam Renang"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
