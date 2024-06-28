import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zebra/core/logger/logger.dart';

import 'cache_constants.dart';

class CacheService extends GetxService {
  late GetStorage _storage;

  Future<CacheService> init() async {
    await GetStorage.init('local');
    _storage = GetStorage('local');
    return this;
  }

  Future<void> write(CacheKeys cacheKey, dynamic value) async {
    try {
      await _storage.write(cacheKey.name, value);
    } catch (e) {
      AppLogger.error(e);
    }
  }

  T? read<T>(CacheKeys cacheKey) {
    return _storage.read<T>(cacheKey.name);
  }

  Future<void> resetData() async {
    await _storage.erase();
  }
}
