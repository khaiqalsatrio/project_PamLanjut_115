import 'dart:convert';

class GetKamarByHotelRequestModel {
  final int? idHotel;

  GetKamarByHotelRequestModel({this.idHotel});

  factory GetKamarByHotelRequestModel.fromJson(String str) =>
      GetKamarByHotelRequestModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetKamarByHotelRequestModel.fromMap(Map<String, dynamic> json) =>
      GetKamarByHotelRequestModel(idHotel: json["id_hotel"]);

  Map<String, dynamic> toMap() => {"id_hotel": idHotel};
}
