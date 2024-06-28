// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AppVersionConfig {
  final String version;
  final String minVersion;
  final String? releaseNote;

  AppVersionConfig({
    required this.version,
    required this.minVersion,
    this.releaseNote,
  });

  AppVersionConfig copyWith({
    String? version,
    String? minVersion,
    String? releaseNote,
  }) {
    return AppVersionConfig(
      version: version ?? this.version,
      minVersion: minVersion ?? this.minVersion,
      releaseNote: releaseNote ?? this.releaseNote,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'version': version,
      'minVersion': minVersion,
      'releaseNote': releaseNote,
    };
  }

  factory AppVersionConfig.fromMap(Map<String, dynamic> map) {
    return AppVersionConfig(
      version: map['version'] as String,
      minVersion: map['minVersion'] as String,
      releaseNote:
          map['releaseNote'] != null ? map['releaseNote'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AppVersionConfig.fromJson(String source) =>
      AppVersionConfig.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'AppVersionConfig(version: $version, minVersion: $minVersion, releaseNote: $releaseNote)';

  @override
  bool operator ==(covariant AppVersionConfig other) {
    if (identical(this, other)) return true;

    return other.version == version &&
        other.minVersion == minVersion &&
        other.releaseNote == releaseNote;
  }

  @override
  int get hashCode =>
      version.hashCode ^ minVersion.hashCode ^ releaseNote.hashCode;
}
