import 'dart:convert';

class GetKamarResponseModel {
  final bool status;
  final List<DataKamarAdmin> data;

  GetKamarResponseModel({required this.status, required this.data});

  factory GetKamarResponseModel.fromJson(String str) =>
      GetKamarResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetKamarResponseModel.fromMap(Map<String, dynamic> json) =>
      GetKamarResponseModel(
        status: json["status"] ?? false,
        data:
            json["data"] == null
                ? []
                : List<DataKamarAdmin>.from(
                  json["data"].map((x) => DataKamarAdmin.fromMap(x)),
                ),
      );

  Map<String, dynamic> toMap() => {
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toMap())),
  };
}

class DataKamarAdmin {
  final int id;
  final String namaKamar;
  final int harga;
  final int stokKamar;
  final String deskripsiKamar;
  final int idHotel;
  final int idUser;

  DataKamarAdmin({
    required this.id,
    required this.namaKamar,
    required this.harga,
    required this.stokKamar,
    required this.deskripsiKamar,
    required this.idHotel,
    required this.idUser,
  });

  factory DataKamarAdmin.fromJson(String str) =>
      DataKamarAdmin.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DataKamarAdmin.fromMap(Map<String, dynamic> json) => DataKamarAdmin(
    id: json["id"],
    namaKamar: json["nama_kamar"],
    harga:
        json["harga"] is int
            ? json["harga"]
            : int.tryParse(json["harga"].toString()) ?? 0,
    stokKamar:
        json["stok_kamar"] is int
            ? json["stok_kamar"]
            : int.tryParse(json["stok_kamar"].toString()) ?? 0,
    deskripsiKamar: json["deskripsi_kamar"],
    idHotel: json["id_hotel"],
    idUser: json["id_user"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "nama_kamar": namaKamar,
    "harga": harga,
    "stok_kamar": stokKamar,
    "deskripsi_kamar": deskripsiKamar,
    "id_hotel": idHotel,
    "id_user": idUser,
  };
}
