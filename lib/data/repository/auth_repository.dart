import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:project_akhir_pam_lanjut_115/data/model/request/auth/login_request_model.dart';
import 'package:project_akhir_pam_lanjut_115/data/model/request/auth/register_request_model.dart';
import 'package:project_akhir_pam_lanjut_115/data/model/response/auth/auth_response_model.dart';
import 'package:project_akhir_pam_lanjut_115/service/service_http_client.dart';

class AuthRepository {
  final ServiceHttpClient _serviceHttpCliet;
  final secureStorage = FlutterSecureStorage();

  AuthRepository(this._serviceHttpCliet);

  Future<Either<String, AuthResponseModel>> login(
    LoginRequestModel requestModel,
  ) async {
    try {
      final response = await _serviceHttpCliet.post(
        // 'user/auth/login.php',
        'login',
        requestModel.toMap(),
      );
      final jsonResponse = json.decode(response.body);
      if (response.statusCode == 200 && jsonResponse['status'] == true) {
        final token = jsonResponse['token'];
        final role = jsonResponse['data']['role'];
        final userId = jsonResponse['data']['id'];
        final email = jsonResponse['data']['email'];
        if (token != null) {
          await secureStorage.write(key: "authToken", value: token);
          await secureStorage.write(key: "customer", value: role ?? '');
          await secureStorage.write(key: "userId", value: userId.toString());
          await secureStorage.write(key: "userEmail", value: email ?? '');
          if (kDebugMode) {
            print("Token disimpan: $token");
          }
        } else {
          if (kDebugMode) {
            print("Token tidak ditemukan di respon login");
          }
        }
        // Kamu bisa buat AuthResponseModel custom dari jsonResponse kalau perlu
        return Right(AuthResponseModel.fromMap(jsonResponse));
      } else {
        return Left(jsonResponse['message'] ?? 'Login failed');
      }
    } catch (e) {
      return Left("An error occurred while logging in: $e");
    }
  }

  Future<Either<String, String>> register(
    RegisterRequestModel requestModel,
  ) async {
    try {
      final response = await _serviceHttpCliet.post(
        // 'user/auth/register.php',
        'register',
        requestModel.toMap(),
      );
      if (kDebugMode) {
        print('Register status code: ${response.statusCode}');
        print('Register response body: ${response.body}');
      }
      final jsonResponse = json.decode(response.body);
      if ((response.statusCode == 200 || response.statusCode == 201) &&
          jsonResponse['status'] == true) {
        return Right(jsonResponse['message'] ?? "Register success");
      } else {
        return Left(jsonResponse['message'] ?? "Registration failed");
      }
    } catch (e) {
      return Left("An error occurred during registration: $e");
    }
  }

  Future<Either<String, AuthResponseModel>> getProfile() async {
    try {
      final token = await secureStorage.read(key: "authToken");
      if (token == null) {
        return Left("Token tidak tersedia. Silakan login kembali.");
      }
      if (kDebugMode) {
        print("🔐 Token: $token");
      }
      final response = await _serviceHttpCliet.getWithToken(
        // 'user/auth/get_profile.php',
        'profile',
        {},
      );
      if (kDebugMode) {
        print("🔐 GET Profile Response: ${response.body}");
      }
      final jsonResponse = json.decode(response.body);
      if (response.statusCode == 200 && jsonResponse['status'] == true) {
        return Right(AuthResponseModel.fromMap(jsonResponse));
      } else {
        return Left(jsonResponse['message'] ?? 'Gagal mengambil profil');
      }
    } catch (e) {
      return Left("Terjadi kesalahan saat mengambil profil: $e");
    }
  }
}
