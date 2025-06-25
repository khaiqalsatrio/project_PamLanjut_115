import 'dart:convert';

class UpdateKamarRequestModel {
  final int? id;
  final String? namaKamar;
  final int? harga;
  final int? stokKamar;
  final String? deskripsiKamar;

  UpdateKamarRequestModel({
    this.id,
    this.namaKamar,
    this.harga,
    this.stokKamar,
    this.deskripsiKamar,
  });

  factory UpdateKamarRequestModel.fromJson(String str) =>
      UpdateKamarRequestModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UpdateKamarRequestModel.fromMap(Map<String, dynamic> json) =>
      UpdateKamarRequestModel(
        id: json["id"],
        namaKamar: json["nama_kamar"],
        harga: json["harga"],
        stokKamar: json["stok_kamar"],
        deskripsiKamar: json["deskripsi_kamar"],
      );

  Map<String, dynamic> toMap() => {
    "id": id,
    "nama_kamar": namaKamar,
    "harga": harga,
    "stok_kamar": stokKamar,
    "deskripsi_kamar": deskripsiKamar,
  };
}
