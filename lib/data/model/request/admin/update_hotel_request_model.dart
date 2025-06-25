import 'dart:convert';

class UpdateHotelRequestModel {
  final String? id;
  final String? namaHotel;
  final String? deskripsiHotel;

  UpdateHotelRequestModel({this.id, this.namaHotel, this.deskripsiHotel});

  factory UpdateHotelRequestModel.fromJson(String str) =>
      UpdateHotelRequestModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UpdateHotelRequestModel.fromMap(Map<String, dynamic> json) =>
      UpdateHotelRequestModel(
        id: json["id"],
        namaHotel: json["nama_hotel"],
        deskripsiHotel: json["deskripsi_hotel"],
      );

  Map<String, dynamic> toMap() => {
    "id": id,
    "nama_hotel": namaHotel,
    "deskripsi_hotel": deskripsiHotel,
  };
}
