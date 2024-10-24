class TokenModel {
  final String accessToken;
  final DateTime expiresAt;

  TokenModel({
    required this.accessToken,
    required this.expiresAt,
  });

  factory TokenModel.fromJson(Map<String, dynamic> json) {
    return TokenModel(
      accessToken: json['accessToken'],
      expiresAt:
          DateTime.now().add(const Duration(hours: 1)), // 토큰 만료시간 (예: 1시간)
    );
  }

  bool get isExpired => DateTime.now().isAfter(expiresAt);

  // 만료 10분 전인지 체크
  bool get needsRefresh =>
      DateTime.now().add(const Duration(minutes: 10)).isAfter(expiresAt);
}
