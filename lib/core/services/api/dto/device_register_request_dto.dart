// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DeviceRegisterRequestDto {
  final String userId;
  final String fcmToken;
  final String model;
  final String os;
  final String brand;

  DeviceRegisterRequestDto({
    required this.userId,
    required this.fcmToken,
    required this.model,
    required this.os,
    required this.brand,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'fcmToken': fcmToken,
      'model': model,
      'os': os,
      'brand': brand,
    };
  }

  factory DeviceRegisterRequestDto.fromMap(Map<String, dynamic> map) {
    return DeviceRegisterRequestDto(
      userId: map['userId'] as String,
      fcmToken: map['fcmToken'] as String,
      model: map['model'] as String,
      os: map['os'] as String,
      brand: map['brand'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory DeviceRegisterRequestDto.fromJson(String source) =>
      DeviceRegisterRequestDto.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
