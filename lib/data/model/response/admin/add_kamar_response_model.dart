import 'dart:convert';

class AddKamarResponseModel {
  final bool? status;
  final String? message;
  final String? error;

  AddKamarResponseModel({this.status, this.message, this.error});

  factory AddKamarResponseModel.fromJson(String str) =>
      AddKamarResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AddKamarResponseModel.fromMap(Map<String, dynamic> json) =>
      AddKamarResponseModel(
        status: json["status"],
        message: json["message"],
        error: json["error"],
      );

  Map<String, dynamic> toMap() => {
    "status": status,
    "message": message,
    "error": error,
  };
}
