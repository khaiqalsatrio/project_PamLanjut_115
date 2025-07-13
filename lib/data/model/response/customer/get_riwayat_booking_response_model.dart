import 'dart:convert';

class GetRiwayatBookingResponseModel {
  final bool? status;
  final String? message;
  final List<DataRiwayat>? data;

  GetRiwayatBookingResponseModel({this.status, this.message, this.data});

  factory GetRiwayatBookingResponseModel.fromJson(String str) =>
      GetRiwayatBookingResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetRiwayatBookingResponseModel.fromMap(Map<String, dynamic> json) =>
      GetRiwayatBookingResponseModel(
        status: json["status"],
        message: json["message"],
        data:
            json["data"] == null
                ? []
                : List<DataRiwayat>.from(
                  json["data"]!.map((x) => DataRiwayat.fromMap(x)),
                ),
      );

  Map<String, dynamic> toMap() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
  };
}

class DataRiwayat {
  final int? id;
  final String? namaKamar;
  final DateTime? checkInDate;
  final DateTime? checkOutDate;
  final int? harga;
  final String? status;
  final String? namaHotel;

  DataRiwayat({
    this.id,
    this.namaKamar,
    this.checkInDate,
    this.checkOutDate,
    this.harga,
    this.status,
    this.namaHotel,
  });

  factory DataRiwayat.fromJson(String str) =>
      DataRiwayat.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DataRiwayat.fromMap(Map<String, dynamic> json) => DataRiwayat(
    id: json["id"],
    namaKamar: json["nama_kamar"],
    checkInDate:
        json["check_in_date"] == null
            ? null
            : DateTime.parse(json["check_in_date"]),
    checkOutDate:
        json["check_out_date"] == null
            ? null
            : DateTime.parse(json["check_out_date"]),
    harga: json["harga"],
    status: json["status"],
    namaHotel: json["nama_hotel"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "nama_kamar": namaKamar,
    "check_in_date": checkInDate?.toIso8601String(),
    "check_out_date": checkOutDate?.toIso8601String(),
    "harga": harga,
    "status": status,
    "nama_hotel": namaHotel,
  };
}
