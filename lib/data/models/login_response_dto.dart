class LoginResponseDto {
  final String accessToken;
  final String refreshToken;
  final String tokenType;
  final int expiresIn;
  final DateTime refreshExpiresAt;
  final String message;

  const LoginResponseDto({
    required this.accessToken,
    required this.refreshToken,
    required this.tokenType,
    required this.expiresIn,
    required this.refreshExpiresAt,
    required this.message,
  });

  factory LoginResponseDto.fromJson(Map<String, dynamic> json) {
    return LoginResponseDto(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
      tokenType: json['tokenType'],
      expiresIn: json['expiresIn'],
      refreshExpiresAt: DateTime.parse(json['refreshExpiresAt']),
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'tokenType': tokenType,
      'expiresIn': expiresIn,
      'refreshExpiresAt': refreshExpiresAt.toIso8601String(),
      'message': message,
    };
  }
}
