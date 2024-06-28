// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

enum AppStatus {
  online,
  maintenance,
}

class AppStatusConfig {
  final String version;
  final AppStatus status;
  final String title;
  final String description;

  AppStatusConfig({
    required this.version,
    required this.status,
    required this.title,
    required this.description,
  });

  AppStatusConfig copyWith({
    String? version,
    AppStatus? status,
    String? title,
    String? description,
  }) {
    return AppStatusConfig(
      version: version ?? this.version,
      status: status ?? this.status,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'version': version,
      'status': status.name,
      'title': title,
      'description': description,
    };
  }

  factory AppStatusConfig.fromMap(Map<String, dynamic> map) {
    return AppStatusConfig(
      version: map['version'] as String,
      status:
          AppStatus.values.firstWhere((e) => e.name == map['status'] as String),
      title: map['title'] as String,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AppStatusConfig.fromJson(String source) =>
      AppStatusConfig.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AppStatusConfig(version: $version, status: $status, title: $title, description: $description)';
  }

  @override
  bool operator ==(covariant AppStatusConfig other) {
    if (identical(this, other)) return true;

    return other.version == version &&
        other.status == status &&
        other.title == title &&
        other.description == description;
  }

  @override
  int get hashCode {
    return version.hashCode ^
        status.hashCode ^
        title.hashCode ^
        description.hashCode;
  }
}
