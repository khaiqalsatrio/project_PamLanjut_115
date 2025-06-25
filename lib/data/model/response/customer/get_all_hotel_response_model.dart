import 'dart:convert';

class GetAllHotelResponseModel {
  final bool? status;
  final List<DataHotel>? data;

  GetAllHotelResponseModel({this.status, this.data});

  factory GetAllHotelResponseModel.fromJson(String str) =>
      GetAllHotelResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetAllHotelResponseModel.fromMap(Map<String, dynamic> json) =>
      GetAllHotelResponseModel(
        status: json["status"],
        data:
            json["data"] == null
                ? []
                : List<DataHotel>.from(
                  (json["data"] as List).map((x) => DataHotel.fromMap(x)),
                ),
      );

  Map<String, dynamic> toMap() => {
    "status": status,
    "data": data?.map((x) => x.toMap()).toList() ?? [],
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
    id: json["id"] is int ? json["id"] : int.tryParse(json["id"].toString()),
    namaHotel: json["nama_hotel"],
    deskripsiHotel: json["deskripsi_hotel"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "nama_hotel": namaHotel,
    "deskripsi_hotel": deskripsiHotel,
  };
}
