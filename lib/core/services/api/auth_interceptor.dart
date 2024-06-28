import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;
import 'package:zebra/core/logger/logger.dart';
import 'package:zebra/core/services/auth/auth_service.dart';

class AuthInterceptor extends Interceptor {
  final Dio dio;
  late AuthService _authService;

  AuthInterceptor(this.dio) {
    _authService = getx.Get.find<AuthService>();
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final tokens = _authService.authTokens;
    String? accessToken = tokens?.accessToken;

    // Add the token to the request headers
    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // _cache[response.requestOptions.uri] = response;
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    AppLogger.debug(err.response?.data.toString());
    if (err.response?.statusCode == 401 &&
        err.response?.data?['errorCode'] == 'JWT_EXPIRED') {
      final tokens = _authService.authTokens;
      String? refreshToken = tokens?.refreshToken;

      if (refreshToken != null) {
        try {
          final newAuthTokens = await _authService.refreshTokens();

          // Retry the original request with the new access token
          final opts = err.requestOptions;
          opts.headers['Authorization'] = 'Bearer ${newAuthTokens.accessToken}';

          final cloneReq = await dio.request(
            opts.path,
            options: Options(
              method: opts.method,
              headers: opts.headers,
            ),
            data: opts.data,
            queryParameters: opts.queryParameters,
          );

          return handler.resolve(cloneReq);
        } catch (e) {
          // If refreshing the token fails, proceed with the error
          return handler.next(err);
        }
      }
    }
    super.onError(err, handler);
  }
}
