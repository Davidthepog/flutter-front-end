class LoginResponse {
  final String accessToken;
  final String tokenType;
  final int expiresIn;
  final Map<String, dynamic> utenza;

  LoginResponse({
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
    required this.utenza,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      accessToken: json['accessToken'] as String,
      tokenType: (json['tokenType'] ?? 'Bearer') as String,
      expiresIn: (json['expiresIn'] ?? 1800) as int,
      utenza: Map<String, dynamic>.from(json['utenza'] ?? {}),
    );
  }
}