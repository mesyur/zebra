import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String get fileName =>
      kReleaseMode ? "./env/.env.prod" : "./env/.env.dev";

  static String get apiUrl {
    if (kDebugMode && Platform.isAndroid) {
      return "http://10.0.2.2:3000";
    }

    return dotenv.env['API_URL'] ?? 'MY_FALLBACK';
  }
}
