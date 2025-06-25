import 'dart:convert';

class GetBookingResponseModel {
  final bool status;
  final List<DataBooking> data;

  GetBookingResponseModel({required this.status, required this.data});

  factory GetBookingResponseModel.fromJson(String str) =>
      GetBookingResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetBookingResponseModel.fromMap(Map<String, dynamic> json) =>
      GetBookingResponseModel(
        status: json["status"] ?? false,
        data:
            (json["data"] as List<dynamic>?)
                ?.map((x) => DataBooking.fromMap(x))
                .toList() ??
            [],
      );

  Map<String, dynamic> toMap() => {
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toMap())),
  };
}

class DataBooking {
  final int id;
  final int idUser;
  final int idKamar;
  final String namaKamar;
  final DateTime? checkInDate;
  final DateTime? checkOutDate;
  final String harga;
  final String status;
  final String? buktiBayar;
  final String namaHotel;

  DataBooking({
    required this.id,
    required this.idUser,
    required this.idKamar,
    required this.namaKamar,
    this.checkInDate,
    this.checkOutDate,
    required this.harga,
    required this.status,
    this.buktiBayar,
    required this.namaHotel,
  });

  factory DataBooking.fromJson(String str) =>
      DataBooking.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DataBooking.fromMap(Map<String, dynamic> json) => DataBooking(
    id: json["id"] ?? 0,
    idUser: json["id_user"] ?? 0,
    idKamar: json["id_kamar"] ?? 0,
    namaKamar: json["nama_kamar"] ?? '',
    checkInDate:
        json["check_in_date"] != null
            ? DateTime.tryParse(json["check_in_date"])
            : null,
    checkOutDate:
        json["check_out_date"] != null
            ? DateTime.tryParse(json["check_out_date"])
            : null,
    harga: json["harga"] ?? '',
    status: json["status"] ?? '',
    buktiBayar: json["bukti_bayar"],
    namaHotel: json["nama_hotel"] ?? '',
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "id_user": idUser,
    "id_kamar": idKamar,
    "nama_kamar": namaKamar,
    "check_in_date": checkInDate?.toIso8601String(),
    "check_out_date": checkOutDate?.toIso8601String(),
    "harga": harga,
    "status": status,
    "bukti_bayar": buktiBayar,
    "nama_hotel": namaHotel,
  };
}
