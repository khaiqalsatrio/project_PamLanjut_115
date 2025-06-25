import 'dart:convert';

class RegisterResponseModel {
  final bool? status;
  final String? message;
  final int? userId;

  RegisterResponseModel({this.status, this.message, this.userId});

  factory RegisterResponseModel.fromJson(String str) =>
      RegisterResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RegisterResponseModel.fromMap(Map<String, dynamic> json) =>
      RegisterResponseModel(
        status: json["status"],
        message: json["message"],
        userId: json["user_id"],
      );

  Map<String, dynamic> toMap() => {
    "status": status,
    "message": message,
    "user_id": userId,
  };
}
