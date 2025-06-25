import 'dart:convert';

class RegisterRequestModel {
  final String? nama;
  final String? email;
  final String? password;
  final String? role;
  final String? adminSecret;

  RegisterRequestModel({
    this.nama,
    this.email,
    this.password,
    this.role,
    this.adminSecret,
  });

  factory RegisterRequestModel.fromJson(String str) =>
      RegisterRequestModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RegisterRequestModel.fromMap(Map<String, dynamic> json) =>
      RegisterRequestModel(
        nama: json["nama"],
        email: json["email"],
        password: json["password"],
        role: json["role"],
        adminSecret: json["admin_secret"],
      );

  Map<String, dynamic> toMap() => {
    "nama": nama,
    "email": email,
    "password": password,
    "role": role,
    "admin_secret": adminSecret,
  };
}
