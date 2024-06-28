import 'package:get/get.dart';
import 'package:zebra/core/logger/logger.dart';
import 'package:zebra/core/routes/app_pages.dart';
import 'package:zebra/core/services/api/api_service.dart';
import 'package:zebra/core/services/api/dto/auth_tokens_dto.dart';
import 'package:zebra/core/services/api/dto/check_login_code_request_dto.dart';
import 'package:zebra/core/services/api/dto/login_request_dto.dart';
import 'package:zebra/core/services/api/dto/login_response_dto.dart';
import 'package:zebra/core/services/secure_storage/secure_storage_constants.dart';
import 'package:zebra/core/services/secure_storage/secure_storage_service.dart';

class AuthService extends GetxService {
  final _apiService = Get.find<ApiService>();
  final _secureStorageService = Get.find<SecureStorageService>();

  final _isAuthenticated = false.obs;
  bool get isAuthenticated => _isAuthenticated.value;
  void setAuthenticated(bool isAuthenticated) {
    _isAuthenticated.value = isAuthenticated;
  }

  final _authTokens = Rxn<AuthTokensDto>();
  AuthTokensDto? get authTokens => _authTokens.value;
  void setAuthTokens(AuthTokensDto? value) {
    _authTokens.value = value;
  }

  Future<AuthService> init() async {
    try {
      await initAuthTokens();
    } catch (e) {
      AppLogger.error(e);
    }

    return this;
  }

  Future<AuthTokensDto> refreshTokens() async {
    try {
      if (authTokens == null) {
        throw Exception('No refresh token found');
      }

      var response = await _apiService.refreshTokens(authTokens!.refreshToken);

      await saveAuthTokens(response);

      return response;
    } catch (e) {
      setAuthenticated(false);
      Get.toNamed(Routes.welcome);
      rethrow;
    }
  }

  Future<void> saveAuthTokens(AuthTokensDto tokens) async {
    try {
      setAuthTokens(tokens);

      await _secureStorageService.write(
        SecureCacheKeys.authTokens,
        tokens.toJson(),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> initAuthTokens() async {
    try {
      final credentials =
          await _secureStorageService.read(SecureCacheKeys.authTokens);

      if (credentials != null) {
        setAuthTokens(AuthTokensDto.fromJson(credentials));
        setAuthenticated(true);
      } else {
        await signOut();
      }
    } catch (e) {
      clearUser();
      rethrow;
    }
  }

  Future<LoginResponseDto> login(LoginRequestDto req) async {
    try {
      return await _apiService.login(req);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> clearUser() async {
    try {
      setAuthTokens(null);
      setAuthenticated(false);

      await _secureStorageService.delete(SecureCacheKeys.authTokens);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await clearUser();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> checkLoginCode(CheckLoginCodeRequestDto req) async {
    try {
      final user = await _apiService.checkLoginCode(req);

      AuthTokensDto tokens = AuthTokensDto(
        userId: user.id.toString(),
        accessToken: user.token!,
        refreshToken: user.token!,
      );

      setAuthenticated(true);

      await saveAuthTokens(tokens);

      // await Get.find<StartUpService>().initApp();
    } catch (e) {
      rethrow;
    }
  }
}
