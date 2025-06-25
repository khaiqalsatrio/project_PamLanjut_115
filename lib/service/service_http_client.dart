import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ServiceHttpClient {
  // Ganti dengan IP lokal sesuai PC kamu + folder project
  final String baseUrl = 'http://10.0.2.2/api_inapgo/';
  final secureStorage = FlutterSecureStorage();

  /// POST tanpa token
  Future<http.Response> post(String endpoint, Map<String, dynamic> body) async {
    final url = Uri.parse("$baseUrl$endpoint");
    if (kDebugMode) {
      print("POST URL: $url");
      print("BODY: $body");
    }
    try {
      final response = await http.post(
        url,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );
      return response;
    } catch (e) {
      throw Exception("POST request failed: $e");
    }
  }

  /// GET tanpa token
  Future<http.Response> get(
    String endpoint, {
    required Map<String, String> headers,
  }) async {
    final url = Uri.parse("$baseUrl$endpoint");
    if (kDebugMode) {
      print("GET URL: $url");
    }
    try {
      final response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );
      return response;
    } catch (e) {
      throw Exception("GET request failed: $e");
    }
  }

  /// POST dengan token
  Future<http.Response> postWithToken(String endpoint, dynamic body) async {
    final token = await secureStorage.read(key: "authToken");
    final url = Uri.parse("$baseUrl$endpoint");
    if (token == null) {
      throw Exception("Token is null. Please login again.");
    }
    if (kDebugMode) {
      print("🔐 POST with Token URL: $url");
      print("🔐 Token: $token");
      print("📦 BODY: $body");
    }
    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: body is String ? body : json.encode(body),
      );
      if (kDebugMode) {
        print("STATUS: ${response.statusCode}");
        print("RESPONSE BODY: ${response.body}");
      }
      return response;
    } catch (e) {
      throw Exception("POST with token failed: $e");
    }
  }

  /// GET dengan token
  Future<http.Response> getWithToken(
    String endpoint,
    Map<String, String> map,
  ) async {
    final token = await secureStorage.read(key: "authToken");
    final url = Uri.parse("$baseUrl$endpoint");
    if (kDebugMode) {
      print("🔐 GET with Token URL: $url");
      print("🔐 Token: $token");
    }
    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );
      return response;
    } catch (e) {
      throw Exception("GET with token failed: $e");
    }
  }
}
