// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';

import 'app_status_config.dart';
import 'app_version_config.dart';

class RemoteConfig {
  final AppStatusConfig appStatusConfig;
  final AppVersionConfig appVersionConfig;

  RemoteConfig({
    required this.appStatusConfig,
    required this.appVersionConfig,
  });

  RemoteConfig copyWith({
    AppStatusConfig? appStatusConfig,
    AppVersionConfig? appVersionConfig,
  }) {
    return RemoteConfig(
      appStatusConfig: appStatusConfig ?? this.appStatusConfig,
      appVersionConfig: appVersionConfig ?? this.appVersionConfig,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'appStatusConfig': appStatusConfig.toMap(),
      'appVersionConfig': appVersionConfig.toMap(),
    };
  }

  factory RemoteConfig.fromMap(Map<String, dynamic> map) {
    return RemoteConfig(
      appStatusConfig:
          AppStatusConfig.fromMap(map['app_status'] as Map<String, dynamic>),
      appVersionConfig:
          AppVersionConfig.fromMap(map['app_version'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory RemoteConfig.fromJson(String source) =>
      RemoteConfig.fromMap(json.decode(source) as Map<String, dynamic>);

  factory RemoteConfig.remoteConfig(Map<String, RemoteConfigValue> map) {
    return RemoteConfig(
      appStatusConfig: AppStatusConfig.fromJson(map['app_status']!.asString()),
      appVersionConfig:
          AppVersionConfig.fromJson(map['app_version']!.asString()),
    );
  }

  @override
  String toString() =>
      'RemoteConfig(appStatusConfig: $appStatusConfig, appVersionConfig: $appVersionConfig)';

  @override
  bool operator ==(covariant RemoteConfig other) {
    if (identical(this, other)) return true;

    return other.appStatusConfig == appStatusConfig &&
        other.appVersionConfig == appVersionConfig;
  }

  @override
  int get hashCode => appStatusConfig.hashCode ^ appVersionConfig.hashCode;
}
