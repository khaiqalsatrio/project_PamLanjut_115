import 'dart:convert';

class AddHotelResponseModel {
  final bool? status;
  final String? message;

  AddHotelResponseModel({this.status, this.message});

  factory AddHotelResponseModel.fromJson(String str) =>
      AddHotelResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AddHotelResponseModel.fromMap(Map<String, dynamic> json) =>
      AddHotelResponseModel(status: json["status"], message: json["message"]);

  Map<String, dynamic> toMap() => {"status": status, "message": message};
}
