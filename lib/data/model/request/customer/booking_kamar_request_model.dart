import 'dart:convert';

class BookingKamarRequestModel {
  final int? idKamar;
  final DateTime? checkInDate;
  final DateTime? checkOutDate;

  BookingKamarRequestModel({this.idKamar, this.checkInDate, this.checkOutDate});

  factory BookingKamarRequestModel.fromJson(String str) =>
      BookingKamarRequestModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BookingKamarRequestModel.fromMap(Map<String, dynamic> json) =>
      BookingKamarRequestModel(
        idKamar: json["id_kamar"],
        checkInDate:
            json["check_in_date"] == null
                ? null
                : DateTime.parse(json["check_in_date"]),
        checkOutDate:
            json["check_out_date"] == null
                ? null
                : DateTime.parse(json["check_out_date"]),
      );

  Map<String, dynamic> toMap() => {
    "id_kamar": idKamar,
    "check_in_date":
        checkInDate != null
            ? "${checkInDate!.year.toString().padLeft(4, '0')}-${checkInDate!.month.toString().padLeft(2, '0')}-${checkInDate!.day.toString().padLeft(2, '0')}"
            : null,
    "check_out_date":
        checkOutDate != null
            ? "${checkOutDate!.year.toString().padLeft(4, '0')}-${checkOutDate!.month.toString().padLeft(2, '0')}-${checkOutDate!.day.toString().padLeft(2, '0')}"
            : null,
  };
}
