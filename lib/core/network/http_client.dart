import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../error/exceptions.dart';
import 'network_info.dart';

class AppHttpClient {
  final http.Client client;

  AppHttpClient(this.client);

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
  Future<dynamic> get(String url, {String? token}) async {
    try {
      await _checkInternet();
      final response = await client.get(
        Uri.parse(url),
        headers: _jsonHeaders(token: token),
      );
      return _handleResponse(response);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  /// ---------------- POST (JSON) ----------------
  Future<dynamic> post(
    String url,
    Map<String, dynamic> body, {
    String? token,
  }) async {
    try {
      await _checkInternet();
      final response = await client.post(
        Uri.parse(url),
        headers: _jsonHeaders(token: token),
        body: json.encode(body),
      );
      return _handleResponse(response);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  /// ---------------- PUT ----------------
  Future<dynamic> put(
    String url,
    Map<String, dynamic> body, {
    String? token,
  }) async {
    try {
      await _checkInternet();
      final response = await client.put(
        Uri.parse(url),
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
    String url,
    Map<String, dynamic> body, {
    String? token,
  }) async {
    try {
      await _checkInternet();
      final response = await client.patch(
        Uri.parse(url),
        headers: _jsonHeaders(token: token),
        body: json.encode(body),
      );
      return _handleResponse(response);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  /// ---------------- DELETE ----------------
  Future<dynamic> delete(String url, {String? token}) async {
    try {
      await _checkInternet();
      final response = await client.delete(
        Uri.parse(url),
        headers: _jsonHeaders(token: token),
      );
      return _handleResponse(response);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  /// ---------------- POST FORM DATA (FILE UPLOAD) ----------------
  Future<dynamic> postMultipart(
    String url, {
    required Map<String, String> fields,
    List<File>? files,
    String fileKey = 'file',
    String? token,
  }) async {
    try {
      await _checkInternet();

      final request = http.MultipartRequest('POST', Uri.parse(url));

      request.headers.addAll({
        'Accept': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      });

      request.fields.addAll(fields);

      if (files != null && files.isNotEmpty) {
        for (final file in files) {
          request.files.add(
            await http.MultipartFile.fromPath(fileKey, file.path),
          );
        }
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

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
        return json.decode(response.body);

      case 400:
        throw ServerException('Bad Request: ${response.body}');

      case 401:
      case 403:
        throw ServerException('Unauthorized: ${response.body}');

      case 404:
        throw ServerException('Not Found: ${response.body}');

      case 500:
      default:
        throw ServerException('Server Error [$statusCode]: ${response.body}');
    }
  }
}
