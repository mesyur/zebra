import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:zebra/core/exceptions/base_exception.dart';
import 'package:zebra/core/logger/logger.dart';
import 'package:zebra/core/services/api/dto/login_response_dto.dart';

import 'api_method.dart';
import 'api_paths.dart';
import 'dio_factory.dart';
import 'dto/auth_tokens_dto.dart';
import 'dto/check_login_code_request_dto.dart';
import 'dto/login_request_dto.dart';

class ApiService extends GetxService {
  Future<ApiService> init() async {
    return this;
  }

  Future<T> _request<T>(
      {required String path,
      required ApiMethod method,
      Object? data,
      T Function(dynamic data)? fromData,
      Options? options,
      bool authInterceptor = false,
      Map<String, dynamic>? queryParameters}) async {
    try {
      final dio = DioFactory.create(
        authInterceptor: authInterceptor,
      );

      options = (options ?? Options()).copyWith(
        method: method.name,
      );

      final response = await dio.request(
        path,
        options: options,
        data: data,
        queryParameters: queryParameters,
      );

      if (fromData != null) {
        return fromData(response.data);
      }

      return response.data;
    } catch (e) {
      AppLogger.error(e.toString());
      if (e is DioException) {
        /* if (e.response?.data != null) {
          throw ApiException.fromMap(e.response?.data);
        } */

        if (e.error is SocketException) {
          throw BaseException.network((e.error as SocketException).message);
        }

        throw BaseException.unknown(e.message);
      }

      throw BaseException.unknown(e.toString());
    }
  }

  Future<AuthTokensDto> refreshTokens(String refreshToken) {
    return _request(
      path: ApiPaths.refreshTokens,
      method: ApiMethod.POST,
      fromData: (map) => AuthTokensDto.fromMap(map),
      options: Options(
        headers: {
          "Authorization": "Bearer $refreshToken",
        },
      ),
    );
  }

  Future<LoginResponseDto> login(LoginRequestDto req) {
    return _request(
      path: ApiPaths.login,
      method: ApiMethod.POST,
      data: req.toMap(),
      fromData: (map) {
        return LoginResponseDto.fromMap(map['data']);
      },
    );
  }

  Future<UserDto> checkLoginCode(CheckLoginCodeRequestDto req) {
    return _request(
      path: ApiPaths.checkLoginCode,
      method: ApiMethod.POST,
      data: req.toMap(),
      fromData: (map) {
        log(map.toString());
        return UserDto.fromMap(map['data']['user']);
      },
    );
  }
}
