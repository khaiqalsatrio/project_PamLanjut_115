import 'dart:convert';

class AddHotelRequestModel {
  final String? namaHotel;
  final String? deskripsiHotel;

  AddHotelRequestModel({this.namaHotel, this.deskripsiHotel});

  factory AddHotelRequestModel.fromJson(String str) =>
      AddHotelRequestModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AddHotelRequestModel.fromMap(Map<String, dynamic> json) =>
      AddHotelRequestModel(
        namaHotel: json["nama_hotel"],
        deskripsiHotel: json["deskripsi_hotel"],
      );

  Map<String, dynamic> toMap() => {
    "nama_hotel": namaHotel,
    "deskripsi_hotel": deskripsiHotel,
  };
}
