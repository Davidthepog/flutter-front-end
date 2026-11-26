class RefreshRequestDto {
  final String refreshToken;

  const RefreshRequestDto({required this.refreshToken});

  factory RefreshRequestDto.fromJson(Map<String, dynamic> json) {
    return RefreshRequestDto(refreshToken: json['refreshToken']);
  }

  Map<String, dynamic> toJson() {
    return {'refreshToken': refreshToken};
  }
}
