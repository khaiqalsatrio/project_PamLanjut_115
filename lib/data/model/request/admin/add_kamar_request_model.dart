import 'dart:convert';

class AddKamarRequestModel {
  final String? namaKamar;
  final int? harga;
  final int? stokKamar;
  final String? deskripsiKamar;

  AddKamarRequestModel({
    this.namaKamar,
    this.harga,
    this.stokKamar,
    this.deskripsiKamar,
  });

  factory AddKamarRequestModel.fromJson(String str) =>
      AddKamarRequestModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AddKamarRequestModel.fromMap(Map<String, dynamic> json) =>
      AddKamarRequestModel(
        namaKamar: json["nama_kamar"],
        harga: json["harga"],
        stokKamar: json["stok_kamar"],
        deskripsiKamar: json["deskripsi_kamar"],
      );

  Map<String, dynamic> toMap() => {
    "nama_kamar": namaKamar,
    "harga": harga,
    "stok_kamar": stokKamar,
    "deskripsi_kamar": deskripsiKamar,
  };
}
