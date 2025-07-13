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
  final String? alamat;
  final String? kota;
  final String? imageUrl; // ⬅️ ganti dari imageUrl ke imageBase64

  DataHotel({
    this.id,
    this.namaHotel,
    this.deskripsiHotel,
    this.alamat,
    this.kota,
    this.imageUrl,
  });

  factory DataHotel.fromMap(Map<String, dynamic> json) => DataHotel(
    id: json["id"],
    namaHotel: json["nama_hotel"],
    deskripsiHotel: json["deskripsi_hotel"],
    alamat: json["alamat"],
    kota: json["kota"],
    imageUrl: json["image_url"], // field ini harus dikirim dari backend
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "nama_hotel": namaHotel,
    "deskripsi_hotel": deskripsiHotel,
    "alamat": alamat,
    "kota": kota,
    "image_url": imageUrl,
  };
}
