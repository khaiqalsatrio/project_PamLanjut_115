import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart'; // untuk basename()
// ignore: depend_on_referenced_packages
import 'package:http_parser/http_parser.dart'; // untuk MediaType()

class ServiceHttpClient {
  // final String baseUrl = 'http://10.0.2.2/api_inapgo/'; // ini URL dengan Inapgo

  // ini URL dengan Laravel
  final String baseUrl = 'http://10.0.2.2:8000/api/';

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

  /// Update dengan token
  Future<http.Response> putWithToken(String endpoint, dynamic body) async {
    final token = await secureStorage.read(key: "authToken");
    final url = Uri.parse("$baseUrl$endpoint");
    if (token == null) {
      throw Exception("Token is null. Please login again.");
    }
    if (kDebugMode) {
      print("🔐 PUT with Token URL: $url");
      print("🔐 Token: $token");
      print("📦 BODY: $body");
    }
    try {
      final response = await http.put(
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
      throw Exception("PUT with token failed: $e");
    }
  }

  /// DELETE dengan token
  Future<http.Response> deleteWithToken(String endpoint) async {
    final token = await secureStorage.read(key: "authToken");
    final url = Uri.parse("$baseUrl$endpoint");
    if (token == null) {
      throw Exception("Token is null. Please login again.");
    }
    if (kDebugMode) {
      print("🔐 DELETE with Token URL: $url");
      print("🔐 Token: $token");
    }
    try {
      final response = await http.delete(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );
      if (kDebugMode) {
        print("STATUS: ${response.statusCode}");
        print("RESPONSE BODY: ${response.body}");
      }
      return response;
    } catch (e) {
      throw Exception("DELETE with token failed: $e");
    }
  }

  /// Multipart POST (upload image) dengan token
  Future<http.Response> postMultipartWithToken({
    required String endpoint,
    required File file,
    String fieldName = 'image',
  }) async {
    final token = await secureStorage.read(key: "authToken");
    final url = Uri.parse("$baseUrl$endpoint");
    if (token == null) {
      throw Exception("Token is null. Please login again.");
    }
    final mimeType = lookupMimeType(file.path) ?? 'application/octet-stream';
    final mediaTypeParts = mimeType.split('/');
    final request = http.MultipartRequest('POST', url);
    request.headers['Authorization'] = 'Bearer $token';
    request.headers['Accept'] = 'application/json';
    request.files.add(
      await http.MultipartFile.fromPath(
        fieldName,
        file.path,
        filename: basename(file.path),
        contentType: MediaType(mediaTypeParts[0], mediaTypeParts[1]),
      ),
    );
    if (kDebugMode) {
      print("📤 UPLOAD TO: $url");
      print("📦 File: ${file.path}");
      print("🧾 MIME: $mimeType");
      print("🔐 Token: $token");
    }
    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);
    if (kDebugMode) {
      print("📥 Response status: ${response.statusCode}");
      print("📥 Response body: ${response.body}");
    }
    return response;
  }
}
