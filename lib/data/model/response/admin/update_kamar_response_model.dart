import 'dart:convert';

class UpdateKamarResponseModel {
  final bool? status;
  final String? message;

  UpdateKamarResponseModel({this.status, this.message});

  factory UpdateKamarResponseModel.fromJson(String str) =>
      UpdateKamarResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UpdateKamarResponseModel.fromMap(Map<String, dynamic> json) =>
      UpdateKamarResponseModel(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {"status": status, "message": message};
}
