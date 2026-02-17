import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:pdi_dost/core/constants/api_constants.dart';
import '../error/exceptions.dart';
import 'network_info.dart';

class AppHttpClient {
  final http.Client client;

  AppHttpClient(this.client);

  /// Helper to get full logic URL
  Uri _getUri(String endpoint) {
    if (endpoint.startsWith('http')) {
      return Uri.parse(endpoint);
    }
    return Uri.parse('${ApiConstants.baseUrl}$endpoint');
  }

  /// ---------------- COMMON HEADERS ----------------
  Map<String, String> _jsonHeaders({String? token}) => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    if (token != null) 'Authorization': 'Bearer $token',
  };

  Future<void> _checkInternet() async {
    if (!await NetworkInfo.isConnected()) {
      throw ServerException(
        'No internet connection. Please check your network and try again.',
      );
    }
  }

  /// ---------------- GET ----------------
  Future<dynamic> get(String endpoint, {String? token}) async {
    try {
      await _checkInternet();
      final uri = _getUri(endpoint);
      debugPrint('API GET: $uri');
      final response = await client.get(
        uri,
        headers: _jsonHeaders(token: token),
      );
      debugPrint('API RESPONSE [$uri]: ${response.body}');
      return _handleResponse(response);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  /// ---------------- POST (JSON) ----------------
  Future<dynamic> post(
    String endpoint,
    Map<String, dynamic> body, {
    String? token,
  }) async {
    try {
      await _checkInternet();
      final uri = _getUri(endpoint);
      debugPrint('API POST: $uri');
      debugPrint('API BODY: ${json.encode(body)}');
      final response = await client.post(
        uri,
        headers: _jsonHeaders(token: token),
        body: json.encode(body),
      );
      debugPrint('API RESPONSE [$uri]: ${response.body}');
      return _handleResponse(response);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  /// ---------------- PUT ----------------
  Future<dynamic> put(
    String endpoint,
    Map<String, dynamic> body, {
    String? token,
  }) async {
    try {
      await _checkInternet();
      final uri = _getUri(endpoint);
      final response = await client.put(
        uri,
        headers: _jsonHeaders(token: token),
        body: json.encode(body),
      );
      return _handleResponse(response);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  /// ---------------- PATCH ----------------
  Future<dynamic> patch(
    String endpoint,
    Map<String, dynamic> body, {
    String? token,
  }) async {
    try {
      await _checkInternet();
      final uri = _getUri(endpoint);
      final response = await client.patch(
        uri,
        headers: _jsonHeaders(token: token),
        body: json.encode(body),
      );
      return _handleResponse(response);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  /// ---------------- DELETE ----------------
  Future<dynamic> delete(String endpoint, {String? token}) async {
    try {
      await _checkInternet();
      final uri = _getUri(endpoint);
      final response = await client.delete(
        uri,
        headers: _jsonHeaders(token: token),
      );
      return _handleResponse(response);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  /// ---------------- POST FORM DATA (FILE UPLOAD) ----------------
  Future<dynamic> postMultipart(
    String endpoint, {
    required Map<String, String> fields,
    Map<String, File>? files,
    String? token,
  }) async {
    try {
      await _checkInternet();
      final uri = _getUri(endpoint);
      debugPrint('API MULTIPART: $uri');
      debugPrint('API FIELDS: $fields');

      final request = http.MultipartRequest('POST', uri);

      request.headers.addAll({
        'Accept': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      });

      request.fields.addAll(fields);

      if (files != null && files.isNotEmpty) {
        for (final entry in files.entries) {
          debugPrint('API FILE [${entry.key}]: ${entry.value.path}');
          request.files.add(
            await http.MultipartFile.fromPath(entry.key, entry.value.path),
          );
        }
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      debugPrint('API RESPONSE [$uri]: ${response.body}');

      return _handleResponse(response);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  /// ---------------- RESPONSE HANDLER ----------------
  dynamic _handleResponse(http.Response response) {
    final statusCode = response.statusCode;

    if (response.body.isEmpty) return null;

    switch (statusCode) {
      case 200:
      case 201:
      case 400: // Bad Request
      case 401: // Unauthorized (often contains 'Invalid password' message)
      case 422: // Unprocessable Content
        return json.decode(response.body);

      case 403:
        throw ServerException('Access Forbidden [403]');

      case 404:
        throw ServerException('API Endpoint Not Found [404]');

      case 500:
        throw ServerException('Internal Server Error [500]');

      default:
        throw ServerException('Network Error [$statusCode]');
    }
  }
}
