// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'base_exception.dart';

class ApiException extends BaseException {
  final String path;
  final DateTime timestamp;
  final int statusCode;

  ApiException({
    required super.errorCode,
    super.message,
    required this.path,
    required this.timestamp,
    required this.statusCode,
  });

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'errorCode': errorCode,
      'message': message,
      'path': path,
      'timestamp': timestamp.millisecondsSinceEpoch,
      'statusCode': statusCode,
    };
  }

  factory ApiException.fromMap(Map<String, dynamic> map) {
    return ApiException(
      errorCode: map['errorCode'] as String,
      message: map['message'] != null ? map['message'] as String : null,
      path: map['path'] as String,
      timestamp: DateTime.parse(map['timestamp']),
      statusCode: map['statusCode'] as int,
    );
  }

  @override
  String toString() =>
      'ApiException(path: $path, timestamp: $timestamp, statusCode: $statusCode)';
}
