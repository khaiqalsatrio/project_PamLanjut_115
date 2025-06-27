import 'dart:convert';

class GetBookingByHotelResponseModel {
  final bool? status;
  final List<DataBookingAdmin>? data;

  GetBookingByHotelResponseModel({this.status, this.data});

  factory GetBookingByHotelResponseModel.fromJson(String str) =>
      GetBookingByHotelResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetBookingByHotelResponseModel.fromMap(Map<String, dynamic> json) =>
      GetBookingByHotelResponseModel(
        status: json["status"],
        data:
            json["data"] == null
                ? []
                : List<DataBookingAdmin>.from(
                  json["data"]!.map((x) => DataBookingAdmin.fromMap(x)),
                ),
      );

  Map<String, dynamic> toMap() => {
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
  };
}

class DataBookingAdmin {
  final int? id;
  final DateTime? checkInDate;
  final DateTime? checkOutDate;
  final String? status;
  final String? namaKamar;
  final String? namaHotel;
  final int? idUser;
  final String? namaUser;
  final String? emailUser;

  DataBookingAdmin({
    this.id,
    this.checkInDate,
    this.checkOutDate,
    this.status,
    this.namaKamar,
    this.namaHotel,
    this.idUser,
    this.namaUser,
    this.emailUser,
  });

  factory DataBookingAdmin.fromJson(String str) =>
      DataBookingAdmin.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DataBookingAdmin.fromMap(Map<String, dynamic> json) =>
      DataBookingAdmin(
        id: json["id"],
        checkInDate:
            json["check_in_date"] == null
                ? null
                : DateTime.parse(json["check_in_date"]),
        checkOutDate:
            json["check_out_date"] == null
                ? null
                : DateTime.parse(json["check_out_date"]),
        status: json["status"],
        namaKamar: json["nama_kamar"],
        namaHotel: json["nama_hotel"],
        idUser: json["id_user"],
        namaUser: json["nama_user"],
        emailUser: json["email_user"],
      );

  Map<String, dynamic> toMap() => {
    "id": id,
    "check_in_date":
        "${checkInDate!.year.toString().padLeft(4, '0')}-${checkInDate!.month.toString().padLeft(2, '0')}-${checkInDate!.day.toString().padLeft(2, '0')}",
    "check_out_date":
        "${checkOutDate!.year.toString().padLeft(4, '0')}-${checkOutDate!.month.toString().padLeft(2, '0')}-${checkOutDate!.day.toString().padLeft(2, '0')}",
    "status": status,
    "nama_kamar": namaKamar,
    "nama_hotel": namaHotel,
    "id_user": idUser,
    "nama_user": namaUser,
    "email_user": emailUser,
  };
}
