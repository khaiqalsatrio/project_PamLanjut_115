import 'dart:convert';

class GetHotelByUserResponseModel {
  final bool? status;
  final String? message;
  final List<DataHotel>? data;

  GetHotelByUserResponseModel({this.status, this.message, this.data});

  factory GetHotelByUserResponseModel.fromJson(String str) =>
      GetHotelByUserResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetHotelByUserResponseModel.fromMap(Map<String, dynamic> json) =>
      GetHotelByUserResponseModel(
        status: json["status"],
        message: json["message"],
        data:
            json["data"] == null
                ? []
                : List<DataHotel>.from(
                  json["data"]!.map((x) => DataHotel.fromMap(x)),
                ),
      );

  Map<String, dynamic> toMap() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
  };
}

class DataHotel {
  final int? id;
  final String? namaHotel;
  final String? deskripsiHotel;

  DataHotel({this.id, this.namaHotel, this.deskripsiHotel});

  factory DataHotel.fromJson(String str) => DataHotel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DataHotel.fromMap(Map<String, dynamic> json) => DataHotel(
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
