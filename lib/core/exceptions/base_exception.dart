// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:get/get.dart';

class BaseException implements Exception {
  final String errorCode;
  final String? message;

  BaseException({
    required this.errorCode,
    this.message,
  });

  String toLocaleString() {
    final localizedResult = errorCode.tr;

    if (localizedResult != errorCode) {
      return localizedResult;
    }

    return message ?? errorCode;
  }

  BaseException copyWith({
    String? errorCode,
    String? message,
  }) {
    return BaseException(
      errorCode: errorCode ?? this.errorCode,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'errorCode': errorCode,
      'message': message,
    };
  }

  factory BaseException.fromMap(Map<String, dynamic> map) {
    return BaseException(
      errorCode: map['errorCode'] as String,
      message: map['message'] != null ? map['message'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BaseException.fromJson(String source) =>
      BaseException.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'BaseException(errorCode: $errorCode, message: $message)';

  @override
  bool operator ==(covariant BaseException other) {
    if (identical(this, other)) return true;

    return other.errorCode == errorCode && other.message == message;
  }

  @override
  int get hashCode => errorCode.hashCode ^ message.hashCode;

  static unknown(String? message) =>
      BaseException(errorCode: 'UNKNOWN', message: message);

  static network(String? message) =>
      BaseException(errorCode: 'NETWORK_ERROR', message: message);
}
