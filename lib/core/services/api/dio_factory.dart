import 'package:dio/dio.dart';
import 'package:zebra/core/env_config/env_config.dart';
import 'auth_interceptor.dart';

class DioFactory {
  static final BaseOptions _baseOptions = BaseOptions(
    baseUrl: Environment.apiUrl,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    sendTimeout: const Duration(seconds: 10),
  );

  static Dio create({bool authInterceptor = false}) {
    var dio = Dio(_baseOptions);

    if (authInterceptor) {
      dio.interceptors.add(AuthInterceptor(dio));
    }

    return dio;
  }
}
