import 'dart:convert';

class GetKamarByHotelResponseModel {
  final bool? status;
  final List<DataKamar>? data;

  GetKamarByHotelResponseModel({this.status, this.data});

  factory GetKamarByHotelResponseModel.fromJson(String str) =>
      GetKamarByHotelResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetKamarByHotelResponseModel.fromMap(Map<String, dynamic> json) =>
      GetKamarByHotelResponseModel(
        status: json["status"],
        data:
            json["data"] == null
                ? []
                : List<DataKamar>.from(
                  json["data"].map((x) => DataKamar.fromMap(x)),
                ),
      );

  Map<String, dynamic> toMap() => {
    "status": status,
    "data":
        data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class DataKamar {
  final int? id;
  final String? namaKamar;
  final int? harga;
  final int? stokKamar;
  final String? deskripsiKamar;
  final int? idHotel;
  final int? idUser;

  DataKamar({
    this.id,
    this.namaKamar,
    this.harga,
    this.stokKamar,
    this.deskripsiKamar,
    this.idHotel,
    this.idUser,
  });

  factory DataKamar.fromMap(Map<String, dynamic> json) => DataKamar(
    id: json["id"],
    namaKamar: json["nama_kamar"],
    harga: int.tryParse(json["harga"].toString()),
    stokKamar: int.tryParse(json["stok_kamar"].toString()),
    deskripsiKamar: json["deskripsi_kamar"],
    idHotel: json["id_hotel"],
    idUser: json["id_user"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nama_kamar": namaKamar,
    "harga": harga,
    "stok_kamar": stokKamar,
    "deskripsi_kamar": deskripsiKamar,
    "id_hotel": idHotel,
    "id_user": idUser,
  };
}
