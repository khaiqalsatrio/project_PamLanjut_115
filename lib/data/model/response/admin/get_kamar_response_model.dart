import 'dart:convert';

class GetKamarResponseModel {
  final bool? status;
  final List<DataKamarAdmin>? data;

  GetKamarResponseModel({this.status, this.data});

  factory GetKamarResponseModel.fromJson(String str) =>
      GetKamarResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetKamarResponseModel.fromMap(Map<String, dynamic> json) =>
      GetKamarResponseModel(
        status: json["status"],
        data:
            json["data"] == null
                ? []
                : List<DataKamarAdmin>.from(
                  json["data"]!.map((x) => DataKamarAdmin.fromMap(x)),
                ),
      );

  Map<String, dynamic> toMap() => {
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
  };
}

class DataKamarAdmin {
  final int? id;
  final String? namaKamar;
  final String? harga;
  final String? stokKamar;
  final String? deskripsiKamar;
  final int? idHotel;
  final int? idUser;

  DataKamarAdmin({
    this.id,
    this.namaKamar,
    this.harga,
    this.stokKamar,
    this.deskripsiKamar,
    this.idHotel,
    this.idUser,
  });

  factory DataKamarAdmin.fromJson(String str) =>
      DataKamarAdmin.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DataKamarAdmin.fromMap(Map<String, dynamic> json) => DataKamarAdmin(
    id: json["id"],
    namaKamar: json["nama_kamar"],
    harga: json["harga"],
    stokKamar: json["stok_kamar"],
    deskripsiKamar: json["deskripsi_kamar"],
    idHotel: json["id_hotel"],
    idUser: json["id_user"],
  );

  get idKamar => null;

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
