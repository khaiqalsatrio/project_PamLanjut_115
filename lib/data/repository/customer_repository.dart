import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:project_akhir_pam_lanjut_115/data/model/request/customer/booking_kamar_request_model.dart';
import 'package:project_akhir_pam_lanjut_115/data/model/request/customer/get_kamar_by_hotel_request_model.dart';
import 'package:project_akhir_pam_lanjut_115/data/model/response/customer/booking_kamar_response_model.dart';
import 'package:project_akhir_pam_lanjut_115/data/model/response/customer/get_all_hotel_response_model.dart';
import 'package:project_akhir_pam_lanjut_115/data/model/response/customer/get_booking_response_model.dart';
import 'package:project_akhir_pam_lanjut_115/data/model/response/customer/get_kamar_by_hotel_response_model.dart';
import 'package:project_akhir_pam_lanjut_115/service/service_http_client.dart';

class CustomerRepository {
  final ServiceHttpClient _client;

  CustomerRepository(this._client);

  Future<Either<String, BookingKamarResponseModel>> bookingKamar(
    BookingKamarRequestModel requestModel,
  ) async {
    try {
      final response = await _client.postWithToken(
        'user/customer/booking_kamar.php',
        requestModel.toMap(),
      );
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return Right(BookingKamarResponseModel.fromMap(jsonResponse));
      } else {
        return Left('Server error: ${response.statusCode}');
      }
    } catch (e) {
      return Left('Failed to booking kamar: ${e..toString()}');
    }
  }

  Future<Either<String, GetAllHotelResponseModel>> getAllHotel() async {
    try {
      final response = await _client.get(
        'user/customer/get_all_hotel.php',
        headers: {},
      );
      final jsonResponse = json.decode(response.body);
      return Right(GetAllHotelResponseModel.fromMap(jsonResponse));
    } catch (e) {
      return Left('Failed to fetch hotels: $e');
    }
  }

  Future<Either<String, GetKamarByHotelResponseModel>> getKamarByHotel(
    GetKamarByHotelRequestModel request,
  ) async {
    try {
      final response = await _client.post(
        'user/customer/get_kamar_by_hotel.php',
        request.toMap(),
      );
      final jsonResponse = json.decode(response.body);
      return Right(GetKamarByHotelResponseModel.fromMap(jsonResponse));
    } catch (e) {
      return Left('Failed to get kamar: $e');
    }
  }

  Future<Either<String, GetBookingResponseModel>> getBooking(
    int idBooking,
  ) async {
    try {
      final response = await _client.getWithToken(
        'user/customer/get_booking.php',
        {},
      );
      if (kDebugMode) {
        print(" Raw response body: ${response.body}");
      }
      if (response.statusCode == 200) {
        final model = GetBookingResponseModel.fromJson(response.body);
        if (kDebugMode) {
          print("✅ Parsed bookings: ${model.data.length} item(s)");
        }
        return Right(model);
      } else {
        return Left('Server error: ${response.statusCode}');
      }
    } catch (e, stacktrace) {
      if (kDebugMode) {
        print("❌ Exception saat getBooking: $e\n$stacktrace");
      }
      return Left('Failed to get bookings: $e');
    }
  }

  Future<Either<String, String>> uploadBukti(String pathToFile) async {
    try {
      http.MultipartRequest request = http.MultipartRequest(
        'POST',
        Uri.parse('${_client.baseUrl}/user/customer/upload_bukti.php'),
      );
      request.files.add(await http.MultipartFile.fromPath('bukti', pathToFile));
      http.StreamedResponse response = await request.send();
      final result = await response.stream.bytesToString();
      final jsonResponse = json.decode(result);
      if (response.statusCode == 200) {
        return Right(jsonResponse['message'] ?? 'Upload berhasil');
      } else {
        return Left(jsonResponse['message'] ?? 'Upload gagal');
      }
    } catch (e) {
      return Left('Error saat upload bukti: $e');
    }
  }
}
