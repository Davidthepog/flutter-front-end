import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_application_1/model.dart';

class ApiHandler {
  final String baseUri = "http://10.0.2.2:5286/api/utenze";

  Future<List<Utenze>> getUserData() async {
    final uri = Uri.parse(baseUri);
    final response = await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode < 200 || response.statusCode > 299) {
      throw Exception(
        'GET $uri failed (${response.statusCode}): ${response.body}',
      );
    }

    final List<dynamic> jsonData = json.decode(response.body);
    return jsonData.map((json) => Utenze.fromJson(json)).toList();
  }
}
