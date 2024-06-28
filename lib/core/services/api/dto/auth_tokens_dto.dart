// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AuthTokensDto {
  final String userId;
  final String accessToken;
  final String refreshToken;
  AuthTokensDto({
    required this.userId,
    required this.accessToken,
    required this.refreshToken,
  });

  AuthTokensDto copyWith({
    String? userId,
    String? accessToken,
    String? refreshToken,
  }) {
    return AuthTokensDto(
      userId: userId ?? this.userId,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    };
  }

  factory AuthTokensDto.fromMap(Map<String, dynamic> map) {
    return AuthTokensDto(
      userId: map['userId'] as String,
      accessToken: map['accessToken'] as String,
      refreshToken: map['refreshToken'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthTokensDto.fromJson(String source) =>
      AuthTokensDto.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'AuthTokensDto(userId: $userId, accessToken: $accessToken, refreshToken: $refreshToken)';

  @override
  bool operator ==(covariant AuthTokensDto other) {
    if (identical(this, other)) return true;

    return other.userId == userId &&
        other.accessToken == accessToken &&
        other.refreshToken == refreshToken;
  }

  @override
  int get hashCode =>
      userId.hashCode ^ accessToken.hashCode ^ refreshToken.hashCode;
}
