import 'package:get/get.dart';
import 'package:zebra/app/bindings/IntroBinding.dart';
import 'package:zebra/app/bindings/MainPageBinding.dart';
import 'package:zebra/app/bindings/RegisterBinding.dart';
import 'package:zebra/app/view/Auth/Register/Register.dart';
import 'package:zebra/app/view/Intro/Intro.dart';
import 'package:zebra/app/view/MainPage/MainPage.dart';
import 'package:zebra/core/middleware/auth_middleware.dart';
import 'package:zebra/core/middleware/no_auth_middleware.dart';
import 'package:zebra/ui/pages/login/login_view.dart';
import 'package:zebra/ui/pages/login/login_view_binding.dart';
import 'package:zebra/ui/pages/login_code/login_code_view.dart';
import 'package:zebra/ui/pages/login_code/login_code_view_binding.dart';
import 'package:zebra/ui/pages/welcome/welcome_view.dart';
import 'package:zebra/ui/pages/welcome/welcome_view_binding.dart';

part 'app_routes.dart';

class AppPages {
  static String _initial = Routes.login;
  static String get initial => _initial;

  static updateInitial(String route) {
    if (_initial == Routes.maintenance || _initial == Routes.forceUpdate) {
      return;
    }
    _initial = route;
  }

  static final routes = [
    GetPage(
      name: Routes.welcome,
      page: () => const WelcomeView(),
      binding: WelcomeViewBinding(),
      middlewares: [NoAuthMiddleware()],
    ),
    GetPage(
      name: Routes.login,
      page: () => const LoginView(),
      binding: LoginViewBinding(),
      middlewares: [NoAuthMiddleware()],
    ),
    GetPage(
      name: Routes.loginCode,
      page: () => const LoginCodeView(),
      binding: LoginCodeViewBinding(),
      middlewares: [NoAuthMiddleware()],
    ),
    GetPage(
      name: Routes.mainPage,
      page: () => const MainPage(),
      binding: MainPageBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: Routes.register,
      page: () => const Register(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: Routes.intro,
      page: () => const Intro(),
      binding: IntroBinding(),
    ),
  ];
}
