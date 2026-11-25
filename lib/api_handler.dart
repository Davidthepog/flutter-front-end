import 'dart:convert';

import 'package:flutter_application_1/models/login_dto.dart';
import 'package:flutter_application_1/models/login_response_dto.dart';
import 'package:flutter_application_1/models/output_utenza_dto.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/services/auth_service.dart';

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
}
