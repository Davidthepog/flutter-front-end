import 'dart:convert';

import 'package:flutter_application_1/models/output_utenza_dto.dart';
import 'package:http/http.dart' as http;

class ApiHandler {
  final String baseUri = "http://10.0.2.2:5286/api";

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
}
