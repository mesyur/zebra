import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/services.dart';
import 'package:zebra/core/logger/logger.dart';
import 'package:zebra/core/routes/app_pages.dart';

import 'default_config.dart';
import 'dto/app_status_config.dart';
import 'dto/app_version_config.dart';
import 'dto/remote_config.dart';

class RemoteConfigService {
  late final FirebaseRemoteConfig _firebaseRemoteConfig;

  late final RemoteConfig _remoteConfig;

  AppStatusConfig get appStatusConfig => _remoteConfig.appStatusConfig;
  AppVersionConfig get appVersionConfig => _remoteConfig.appVersionConfig;

  Future<RemoteConfigService> init() async {
    await initialize();
    checkAppStatus();
    return this;
  }

  Future<void> initialize() async {
    try {
      _firebaseRemoteConfig = FirebaseRemoteConfig.instance;

      await _firebaseRemoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: const Duration(seconds: 0),
      ));

      await _firebaseRemoteConfig.setDefaults(<String, dynamic>{
        'app_status': json.encode(DefaultConfig.appStatus),
        'app_version': json.encode(DefaultConfig.appVersion)
      });

      await _firebaseRemoteConfig.fetchAndActivate();

      _remoteConfig = RemoteConfig.remoteConfig(_firebaseRemoteConfig.getAll());
    } on PlatformException catch (e) {
      AppLogger.error(
        'Unable to fetch remote config. Cached or default values will be used instead. Error: $e',
      );
    }
  }

  checkAppStatus() {
    if (appStatusConfig.status == AppStatus.maintenance) {
      AppPages.updateInitial(Routes.maintenance);
    }
  }
}
