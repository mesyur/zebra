import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zebra/core/logger/logger.dart';
import 'package:zebra/core/routes/app_pages.dart';
import 'package:zebra/core/services/auth/auth_service.dart';

class NoAuthMiddleware extends GetMiddleware {
  final _authService = Get.find<AuthService>();

/*   @override
  RouteSettings? redirect(String route) {
    return _authService.authenticated || route == '/login'
        ? null
        : RouteSettings(name: '/login');
  } */

  @override
  RouteSettings? redirect(String? route) {
    AppLogger.debug("NoAuthMiddleware redirect: $route");
    return _authService.isAuthenticated
        ? const RouteSettings(name: Routes.home)
        : null;
  }

  /* @override
  GetPage onPageCalled(GetPage page) {
    print('>>> Page ${page.name} called');
    print('>>> User ${authController.username} logged');
    return authController.username != null
        ? page.copyWith(parameter: {'user': authController.username})
        : page;
  }

  @override
  List<Bindings> onBindingsStart(List<Bindings> bindings) {
    // This function will be called right before the Bindings are initialize,
    // then bindings is null
    bindings = [OtherBinding()];
    return bindings;
  }

  @override
  GetPageBuilder onPageBuildStart(GetPageBuilder page) {
    print('Bindings of ${page.toString()} are ready');
    return page;
  }

  @override
  Widget onPageBuilt(Widget page) {
    print('Widget ${page.toStringShort()} will be showed');
    return page;
  }

  @override
  void onPageDispose() {
    print('PageDisposed');
  } */
}
