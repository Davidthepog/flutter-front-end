import 'dart:convert';

import 'package:flutter_application_1/data/models/login_dto.dart';
import 'package:flutter_application_1/data/models/login_response_dto.dart';
import 'package:flutter_application_1/data/models/output_utenza_dto.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/data/services/auth_service.dart';

class ApiHandler {
  final String baseUri = "http://10.0.2.2:5286/api";
  final AuthService _auth = AuthService();

  Future<List<OutputUtenzaDto>> getUserData() async {
    List<OutputUtenzaDto> data = [];
    final uri = Uri.parse("$baseUri/utenze");
    try {
      final response = await http.get(
        uri,
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        final List<dynamic> jsonData = json.decode(response.body);
        data = jsonData.map((json) => OutputUtenzaDto.fromJson(json)).toList();
      }
    } catch (e) {
      return data;
    }
    return data;
  }

  Future<LoginResponseDto> login(LoginDto creds) async {
    final uri = Uri.parse('$baseUri/auth/login');

    final response = await http.post(
      uri,
      headers: {'Content-type': 'application/json; charset=UTF-8'},
      body: json.encode(creds.toJson()),
    );

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      final jsonData = jsonDecode(response.body);
      final loginResponse = LoginResponseDto.fromJson(jsonData);

      //salvataggio dei token in memoria
      await _auth.saveTokens(
        accessToken: loginResponse.accessToken,
        refreshToken: loginResponse.refreshToken,
      );

      return loginResponse;
    }

    throw Exception("Login fallito: ${response.statusCode}");
  }

  Future<LoginResponseDto> refreshTokens() async {
    final refreshToken = await _auth.getRefreshToken();

    if (refreshToken == null) {
      throw Exception("Token non trovato");
    }

    final uri = Uri.parse("$baseUri/auth/refresh");

    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'refreshToken': refreshToken}),
    );
    if (response.statusCode >= 200 && response.statusCode <= 299) {
      final jsonData = jsonDecode(response.body);
      final loginResponse = LoginResponseDto.fromJson(jsonData);
      await _auth.saveTokens(
        accessToken: loginResponse.accessToken,
        refreshToken: loginResponse.refreshToken,
      );

      return loginResponse;
    }
    throw Exception('Refresh fallito: ${response.statusCode}');
  }

  Future<http.Response> authorizedRequest({
    required String method,
    required String endpoint,
    Map<String, dynamic>? body,
  }) async {
    Future<http.Response> sendRequest(String token) async {
      final uri = Uri.parse('$baseUri/$endpoint');

      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      switch (method.toUpperCase()) {
        case 'GET':
          return await http.get(uri, headers: headers);

        case 'POST':
          return await http.post(uri, headers: headers, body: jsonEncode(body));

        case 'PUT':
          return await http.put(uri, headers: headers, body: jsonEncode(body));

        case 'DELETE':
          return await http.delete(uri, headers: headers);

        default:
          throw UnsupportedError('Metodo HTTP non supportato: $method');
      }
    }

    String? accessToken = _auth.accessToken;

    if (accessToken == null) {
      throw Exception('Utente non autenticato');
    }

    var response = await sendRequest(accessToken);

    if (response.statusCode == 401) {
      final refreshResponse = await refreshTokens();

      response = await sendRequest(refreshResponse.accessToken);
    }

    return response;
  }
}
