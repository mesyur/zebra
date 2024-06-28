import 'language.dart';

class LanguageConstants {
  static final List<Language> supportedLanguages = [
    Language(
      code: 'en',
      name: "English",
      countryCode: 'US',
    ),
    Language(
      code: 'tr',
      name: "Turkish",
      countryCode: 'TR',
    ),
  ];

  static final Language defaultLanguage = supportedLanguages.first;
}
