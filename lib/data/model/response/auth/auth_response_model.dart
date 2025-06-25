import 'dart:convert';

class AuthResponseModel {
  final bool? status;
  final String? message;
  final String? token;
  final String? expiredAt;
  final User? user;

  AuthResponseModel({
    this.status,
    this.message,
    this.token,
    this.expiredAt,
    this.user,
  });

  factory AuthResponseModel.fromJson(String str) =>
      AuthResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AuthResponseModel.fromMap(Map<String, dynamic> json) =>
      AuthResponseModel(
        status: json['status'],
        message: json['message'],
        token: json['token'],
        expiredAt: json['expired_at'],
        user: json['data'] == null ? null : User.fromMap(json['data']),
      );

  Map<String, dynamic> toMap() => {
    'status': status,
    'message': message,
    'token': token,
    'expired_at': expiredAt,
    'data': user?.toMap(),
  };
}

class User {
  final int? id;
  final String? nama;
  final String? email;
  final String? role;

  User({this.id, this.nama, this.email, this.role});

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
    id: json['id'],
    nama: json['nama'],
    email: json['email'],
    role: json['role'],
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'nama': nama,
    'email': email,
    'role': role,
  };
}
