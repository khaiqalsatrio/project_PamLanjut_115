import 'dart:convert';

class DeleteKamarResponseModel {
  final bool? status;
  final String? message;

  DeleteKamarResponseModel({this.status, this.message});

  factory DeleteKamarResponseModel.fromJson(String str) =>
      DeleteKamarResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DeleteKamarResponseModel.fromMap(Map<String, dynamic> json) =>
      DeleteKamarResponseModel(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {"status": status, "message": message};
}
