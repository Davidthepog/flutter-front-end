/*import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService {
  // Sostituisci <PORTA> con la porta del tuo backend ASP.NET Core
  static const String _baseUrl = 'https://localhost:7052/api/auth/login';
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<LoginResponse> login({
    required String email,
    required String password,
  }) async {
    final uri = Uri.parse('$_baseUrl/login');

    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email.trim(),
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final loginResponse = LoginResponse.fromJson(data);

      await _storage.write(
        key: 'access_token',
        value: loginResponse.accessToken,
      );
      await _storage.write(
        key: 'utenza',
        value: jsonEncode(loginResponse.utenza),
      );

      return loginResponse;
    } else if (response.statusCode == 401) {
      final err = jsonDecode(response.body) as Map<String, dynamic>?;
      throw Exception(err?['message'] ?? 'Accesso negato');
    } else {
      throw Exception('Errore server (${response.statusCode})');
    }
  }

  Future<String?> getToken() => _storage.read(key: 'access_token');

  Future<void> logout() async {
    await _storage.delete(key: 'access_token');
    await _storage.delete(key: 'utenza');
  }
}*/