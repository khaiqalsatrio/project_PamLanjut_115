import 'dart:convert';

class BookingKamarResponseModel {
  final bool? status;
  final String? message;

  BookingKamarResponseModel({this.status, this.message});

  factory BookingKamarResponseModel.fromJson(String str) =>
      BookingKamarResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BookingKamarResponseModel.fromMap(Map<String, dynamic> json) =>
      BookingKamarResponseModel(
        status: json["status"] as bool?,
        message: json["message"] as String?,
      );

  Map<String, dynamic> toMap() => {"status": status, "message": message};
}
