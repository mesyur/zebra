import 'dart:convert';

import 'package:flutter/widgets.dart';

class Language {
  final String name;
  final String code;
  final String? countryCode;
  Language({
    required this.name,
    required this.code,
    required this.countryCode,
  });

  Language copyWith({
    String? name,
    String? code,
    ValueGetter<String?>? countryCode,
  }) {
    return Language(
      name: name ?? this.name,
      code: code ?? this.code,
      countryCode: countryCode != null ? countryCode() : this.countryCode,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'code': code,
      'countryCode': countryCode,
    };
  }

  factory Language.fromMap(Map<String, dynamic> map) {
    return Language(
      name: map['name'] ?? '',
      code: map['code'] ?? '',
      countryCode: map['countryCode'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Language.fromJson(String source) =>
      Language.fromMap(json.decode(source));

  @override
  String toString() => name;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Language &&
        other.name == name &&
        other.code == code &&
        other.countryCode == countryCode;
  }

  @override
  int get hashCode => name.hashCode ^ code.hashCode ^ countryCode.hashCode;
}
