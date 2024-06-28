import 'package:logger/logger.dart';
import 'logger_filter.dart';

class AppLogger {
  static var logger = Logger(filter: LoggerFilter());

  static info(dynamic message) {
    logger.log(Level.info, message.toString());
  }

  static debug(dynamic message) {
    logger.log(Level.debug, message.toString());
  }

  static warning(dynamic message) {
    logger.log(Level.warning, message.toString());
  }

  static error(dynamic message, {StackTrace? stackTrace}) {
    logger.log(
      Level.error,
      message.toString(),
      stackTrace: message is Error ? message.stackTrace : stackTrace,
      error: message,
    );
  }

  static wtf(dynamic message) {
    logger.log(Level.fatal, message.toString());
  }
}
