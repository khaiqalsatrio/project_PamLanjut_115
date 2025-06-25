import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:project_akhir_pam_lanjut_115/data/model/request/admin/add_hotel_request_model.dart';
import 'package:project_akhir_pam_lanjut_115/data/model/request/admin/add_kamar_request_model.dart';
import 'package:project_akhir_pam_lanjut_115/data/model/request/admin/update_hotel_request_model.dart';
import 'package:project_akhir_pam_lanjut_115/data/model/request/admin/update_kamar_request_model.dart';
import 'package:project_akhir_pam_lanjut_115/data/model/response/admin/get_booking_by_hotel_response_model.dart';
import 'package:project_akhir_pam_lanjut_115/data/model/response/admin/get_hotel_by_user_response_model.dart';
import 'package:project_akhir_pam_lanjut_115/data/model/response/admin/get_kamar_response_model.dart';
import 'package:project_akhir_pam_lanjut_115/service/service_http_client.dart';

class AdminRepository {
  final ServiceHttpClient _client;

  AdminRepository(this._client);

  Future<Either<String, bool>> addHotel(AddHotelRequestModel request) async {
    try {
      final response = await _client.postWithToken(
        'user/admin/hotel/add_hotel.php',
        request.toJson(),
      );
      final jsonResponse = json.decode(response.body);
      return Right(jsonResponse['status'] == true);
    } catch (e) {
      return Left('Failed to add hotel: $e');
    }
  }

  Future<Either<String, bool>> addKamar(AddKamarRequestModel request) async {
    try {
      final response = await _client.postWithToken(
        'user/admin/kamar_hotel/add_kamar.php',
        request.toJson(),
      );
      final jsonResponse = json.decode(response.body);
      return Right(jsonResponse['status'] == true);
    } catch (e) {
      return Left('Failed to add kamar: $e');
    }
  }

  Future<Either<String, bool>> updateHotel(
    UpdateHotelRequestModel request,
  ) async {
    try {
      final response = await _client.postWithToken(
        'user/admin/hotel/update_hotel.php',
        request.toJson(),
      );
      final jsonResponse = json.decode(response.body);
      return Right(jsonResponse['status'] == true);
    } catch (e) {
      return Left('Failed to update hotel: $e');
    }
  }

  Future<Either<String, bool>> updateKamar(
    UpdateKamarRequestModel request,
  ) async {
    try {
      final response = await _client.postWithToken(
        'user/admin/kamar_hotel/update_kamar.php',
        request.toJson(),
      );
      final jsonResponse = json.decode(response.body);
      return Right(jsonResponse['status'] == true);
    } catch (e) {
      return Left('Failed to update hotel: $e');
    }
  }

  Future<Either<String, bool>> deleteKamar(int idKamar) async {
    try {
      final response = await _client.postWithToken(
        'user/admin/kamar_hotel/delete_kamar.php',
        {'id': idKamar.toString()},
      );
      final jsonResponse = json.decode(response.body);
      return Right(jsonResponse['status'] == true);
    } catch (e) {
      return Left('Failed to delete hotel: $e');
    }
  }

  Future<Either<String, bool>> deleteHotel(int idHotel) async {
    try {
      final response = await _client.postWithToken(
        'user/admin/hotel/delete_hotel.php',
        {'id_hotel': idHotel.toString()},
      );
      final jsonResponse = json.decode(response.body);
      return Right(jsonResponse['status'] == true);
    } catch (e) {
      return Left('Failed to delete hotel: $e');
    }
  }

  Future<Either<String, List<DataKamarAdmin>>> getKamar() async {
    try {
      final response = await _client.getWithToken(
        'user/admin/kamar_hotel/get_kamar.php',
        {},
      );
      final jsonResponse = json.decode(response.body);

      if (jsonResponse['status'] == true) {
        final model = GetKamarResponseModel.fromMap(jsonResponse);
        return Right(model.data ?? []);
      } else {
        return Left(jsonResponse['message'] ?? 'Error: status false dari API');
      }
    } catch (e) {
      return Left('Failed to get kamar list: $e');
    }
  }

  Future<Either<String, List<GetBookingByHotelResponseModel>>>
  getBookingByHotel(int idHotel) async {
    try {
      final response = await _client.postWithToken(
        'user/admin/kamar_hotel/get_booking_by_hotel.php',
        {'id_hotel': idHotel.toString()},
      );
      final jsonResponse = json.decode(response.body);
      final bookings =
          (jsonResponse['data'] as List)
              .map((json) => GetBookingByHotelResponseModel.fromJson(json))
              .toList();
      return Right(bookings);
    } catch (e) {
      return Left('Failed to get booking: $e');
    }
  }

  Future<Either<String, GetHotelByUserResponseModel>> getHotel() async {
    try {
      final response = await _client.getWithToken(
        'user/admin/hotel/get_hotel_by_user.php',
        {},
      );

      if (kDebugMode) {
        print('📄 status: ${response.statusCode}, body: ${response.body}');
      }

      if (response.statusCode == 200) {
        final model = GetHotelByUserResponseModel.fromJson(response.body);

        if (model.status == true) {
          return Right(model);
        } else {
          return Left(model.message ?? 'Error: status false from API');
        }
      } else {
        return Left('Server error: ${response.statusCode}');
      }
    } catch (e, stacktrace) {
      if (kDebugMode) {
        print('❌ Exception saat getHotel: $e\n$stacktrace');
      }
      return Left('Failed to get hotel: $e');
    }
  }
}
