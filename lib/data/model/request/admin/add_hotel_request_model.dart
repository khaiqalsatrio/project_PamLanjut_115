import 'dart:convert';

// class AddHotelRequestModel {
//   final String? namaHotel;
//   final String? deskripsiHotel;

//   AddHotelRequestModel({this.namaHotel, this.deskripsiHotel});

//   factory AddHotelRequestModel.fromJson(String str) =>
//       AddHotelRequestModel.fromMap(json.decode(str));

//   String toJson() => json.encode(toMap());

//   factory AddHotelRequestModel.fromMap(Map<String, dynamic> json) =>
//       AddHotelRequestModel(
//         namaHotel: json["nama_hotel"],
//         deskripsiHotel: json["deskripsi_hotel"],
//       );

//   Map<String, dynamic> toMap() => {
//     "nama_hotel": namaHotel,
//     "deskripsi_hotel": deskripsiHotel,
//   };
// }

class AddHotelRequestModel {
  final String? namaHotel;
  final String? deskripsiHotel;
  final String? latitude;
  final String? longitude;
  final String? alamat; // ganti dari "address" menjadi "alamat"
  final String? kota;

  AddHotelRequestModel({
    this.namaHotel,
    this.deskripsiHotel,
    this.latitude,
    this.longitude,
    this.alamat,
    this.kota,
  });

  // Untuk decode dari JSON string
  factory AddHotelRequestModel.fromJson(String str) =>
      AddHotelRequestModel.fromMap(json.decode(str));

  // Untuk encode ke JSON string
  String toJson() => json.encode(toMap());

  // Untuk membuat model dari Map (misalnya response dari API)
  factory AddHotelRequestModel.fromMap(Map<String, dynamic> json) =>
      AddHotelRequestModel(
        namaHotel: json["nama_hotel"],
        deskripsiHotel: json["deskripsi_hotel"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        alamat: json["alamat"], // sudah diperbaiki
        kota: json["kota"],
      );

  // Untuk mengubah model ke Map (sebelum dikirim ke API)
  Map<String, dynamic> toMap() => {
    "nama_hotel": namaHotel,
    "deskripsi_hotel": deskripsiHotel,
    "latitude": latitude,
    "longitude": longitude,
    "alamat": alamat, // sudah diperbaiki
    "kota": kota,
  };
}
