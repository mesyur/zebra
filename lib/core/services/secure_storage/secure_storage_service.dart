import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:zebra/core/logger/logger.dart';

import 'secure_storage_constants.dart';

class SecureStorageService extends GetxService {
  late final FlutterSecureStorage _storage;

  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  IOSOptions _getIOSOptions() => const IOSOptions();

  Future<SecureStorageService> init() async {
    _storage = FlutterSecureStorage(
      aOptions: _getAndroidOptions(),
      iOptions: _getIOSOptions(),
    );

    return this;
  }

  Future<String?> read(SecureCacheKeys cacheKey) async {
    return await _storage.read(key: cacheKey.name);
  }

  Future<void> write(SecureCacheKeys cacheKey, dynamic value) async {
    try {
      await _storage.write(key: cacheKey.name, value: value);
    } catch (e) {
      AppLogger.error(e);
    }
  }

  Future<void> delete(SecureCacheKeys cacheKey) async {
    await _storage.delete(key: cacheKey.name);
  }

  Future<void> resetData() async {
    await _storage.deleteAll();
  }
}
