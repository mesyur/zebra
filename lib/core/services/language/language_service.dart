import 'dart:ui';

import 'package:get/get.dart';
import 'package:zebra/core/services/cache/cache_constants.dart';
import 'package:zebra/core/services/cache/cache_service.dart';
import 'package:zebra/generated/locales.g.dart';

import 'language.dart';
import 'language_constants.dart';

class LanguageService extends GetxService {
  final _cacheService = Get.find<CacheService>();

  final Rx<Language> _language = LanguageConstants.defaultLanguage.obs;
  Language get language => _language.value;

  String? translate(String key) {
    return AppTranslation.translations[language.code]?[key];
  }

  Future<LanguageService> init() async {
    initLanguage();
    return this;
  }

  Locale get locale {
    return Locale(language.code, language.countryCode);
  }

  initLanguage() {
    String? prefferedLanguage = _cacheService.read(CacheKeys.preferredLanguage);

    if (prefferedLanguage == null) {
      if (isSupportedLanguage(Get.deviceLocale?.languageCode ?? '')) {
        prefferedLanguage = Get.deviceLocale!.languageCode;
      } else {
        prefferedLanguage = LanguageConstants.defaultLanguage.code;
      }
    }

    _language.value = LanguageConstants.supportedLanguages
        .firstWhere((element) => element.code == prefferedLanguage);
  }

  isSupportedLanguage(String language) {
    return LanguageConstants.supportedLanguages
        .any((element) => element.code == language);
  }

  changeLanguage(Language language) {
    if (isSupportedLanguage(language.code)) {
      _language.value = language;
      _cacheService.write(
        CacheKeys.preferredLanguage,
        language.code,
      );
      Get.updateLocale(Locale(language.code, language.countryCode));
    } else {
      throw Exception('Unsupported language');
    }
  }

  toggleLanguage() {
    final index = LanguageConstants.supportedLanguages
        .indexWhere((element) => element.code == _language.value.code);

    final nextIndex = index + 1 >= LanguageConstants.supportedLanguages.length
        ? 0
        : index + 1;

    changeLanguage(LanguageConstants.supportedLanguages[nextIndex]);
  }
}
