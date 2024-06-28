import 'package:get/get.dart';
import 'package:zebra/core/logger/logger.dart';
import 'package:zebra/core/services/api/api_service.dart';
import 'package:zebra/core/services/auth/auth_service.dart';

class StartUpService extends GetxService {
  final _apiService = Get.find<ApiService>();
  final _authService = Get.find<AuthService>();

  Future<StartUpService> init() async {
    await initApp();

    return this;
  }

  Future<void> initApp() async {
    try {
      if (!_authService.isAuthenticated) {
        return;
      }

      /*  final data = await _apiService.getInitData();

      _authService.setUser(data.user); */
    } catch (e) {
      AppLogger.error(e);
    }
  }
}
