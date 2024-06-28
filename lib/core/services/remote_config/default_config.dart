import 'dto/app_status_config.dart';

class DefaultConfig {
  static final Map<String, dynamic> appStatus = {
    "version": "0",
    "status": AppStatus.online.name,
    "title": "App is online",
    "description":
        "The app is currently offline for maintenance. Please try again later.",
  };

  static final Map<String, dynamic> appVersion = {
    "version": "1.0.1+1",
    "minVersion": "1.0.0+1",
    "releaseNote": "This is the first version of the app."
  };
}
