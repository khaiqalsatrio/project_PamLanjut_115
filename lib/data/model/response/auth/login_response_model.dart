import 'dart:convert';

class LoginResponseModel {
  final bool? status;
  final String? message;
  final String? token;
  final DateTime? expiredAt;
  final Data? data;

  LoginResponseModel({
    this.status,
    this.message,
    this.token,
    this.expiredAt,
    this.data,
  });

  factory LoginResponseModel.fromJson(String str) =>
      LoginResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LoginResponseModel.fromMap(Map<String, dynamic> json) =>
      LoginResponseModel(
        status: json["status"],
        message: json["message"],
        token: json["token"],
        expiredAt:
            json["expired_at"] == null
                ? null
                : DateTime.parse(json["expired_at"]),
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
    "status": status,
    "message": message,
    "token": token,
    "expired_at": expiredAt?.toIso8601String(),
    "data": data?.toMap(),
  };
}

class Data {
  final String? id;
  final String? nama;
  final String? email;
  final String? role;

  Data({this.id, this.nama, this.email, this.role});

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    id: json["id"],
    nama: json["nama"],
    email: json["email"],
    role: json["role"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "nama": nama,
    "email": email,
    "role": role,
  };
}
