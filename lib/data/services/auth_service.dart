import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  String? _accessToken;

  //Future= js promise

  //Salvataggio dei token in secureStorage

  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    _accessToken = accessToken;
    await _storage.write(key: 'refreshToken', value: refreshToken);
  }

  //getter aToken
  String? get accessToken => _accessToken;

  //async getter per refToken
  Future<String?> getRefreshToken() async {
    return await _storage.read(key: 'refreshToken');
  }

  //logout/elimina token
  Future<void> deleteTokens() async {
    _accessToken = null;
    return await _storage.delete(key: 'refreshToken');
  }
}
