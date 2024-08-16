// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DeviceData {
  final int id;
  final int userId;
  final String fcmToken;
  final String model;
  final String os;
  final String brand;
  final int isActive;

  DeviceData({
    required this.id,
    required this.userId,
    required this.fcmToken,
    required this.model,
    required this.os,
    required this.brand,
    required this.isActive,
  });

  DeviceData copyWith({
    int? id,
    int? userId,
    String? fcmToken,
    String? model,
    String? os,
    String? brand,
    int? isActive,
  }) {
    return DeviceData(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      fcmToken: fcmToken ?? this.fcmToken,
      model: model ?? this.model,
      os: os ?? this.os,
      brand: brand ?? this.brand,
      isActive: isActive ?? this.isActive,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'fcmToken': fcmToken,
      'model': model,
      'os': os,
      'brand': brand,
      'isActive': isActive,
    };
  }

  factory DeviceData.fromMap(Map<String, dynamic> map) {
    return DeviceData(
      id: map['id'] as int,
      userId: map['userId'] as int,
      fcmToken: map['fcmToken'] as String,
      model: map['model'] as String,
      os: map['os'] as String,
      brand: map['brand'] as String,
      isActive: map['isActive'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory DeviceData.fromJson(String source) =>
      DeviceData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DeviceData(id: $id, userId: $userId, fcmToken: $fcmToken, model: $model, os: $os, brand: $brand, isActive: $isActive)';
  }

  @override
  bool operator ==(covariant DeviceData other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.userId == userId &&
        other.fcmToken == fcmToken &&
        other.model == model &&
        other.os == os &&
        other.brand == brand &&
        other.isActive == isActive;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        userId.hashCode ^
        fcmToken.hashCode ^
        model.hashCode ^
        os.hashCode ^
        brand.hashCode ^
        isActive.hashCode;
  }
}
