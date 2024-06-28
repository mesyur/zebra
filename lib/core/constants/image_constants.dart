class ImageConstants {
  static const logo = 'assets/app/logo.png';
  static const textLogo = 'assets/images/logo/text_logo.png';
  static const countryLogoBase = 'assets/flags';

  static countryLogo(String countryCode) {
    return '$countryLogoBase/$countryCode.png';
  }
}
