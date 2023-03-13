import 'package:get/get.dart';
import '../bindings/CallBinding.dart';
import '../bindings/ContactUsBinding.dart';
import '../bindings/HelpBinding.dart';
import '../bindings/IntroBinding.dart';
import '../bindings/LastCallBinding.dart';
import '../bindings/LegalInformationBinding.dart';
import '../bindings/LegalInformationPageViewBinding.dart';
import '../bindings/LoginBinding.dart';
import '../bindings/MainPageBinding.dart';
import '../bindings/PinBinding.dart';
import '../bindings/ProfileBinding.dart';
import '../bindings/RegisterBinding.dart';
import '../bindings/ReportUserBinding.dart';
import '../bindings/SssBinding.dart';
import '../middleware/LoginMiddleware.dart';
import '../view/Auth/Login/Login.dart';
import '../view/Auth/Pin/Pin.dart';
import '../view/Auth/Register/Register.dart';
import '../view/CallPage/CallPage.dart';
import '../view/Help/Help.dart';
import '../view/Help/HelpPages/ContactUs/ContactUs.dart';
import '../view/Help/HelpPages/LegalInformation/LegalInformation.dart';
import '../view/Help/HelpPages/SssPage/Sss.dart';
import '../view/Intro/Intro.dart';
import '../view/LastCall/BlockedUsers.dart';
import '../view/LastCall/FavoriteUsers.dart';
import '../view/LastCall/LastCall.dart';
import '../view/LastCall/ReportUser.dart';
import '../view/WIDGETS/LegalInformationPageView.dart';
import '../view/MainPage/MainPage.dart';
import '../view/Profile/Profile.dart';



appRoutes() => [
  GetPage(
      name: '/Intro',
      page: () => const Intro(),
      binding: IntroBinding(),
      transitionDuration: const Duration(milliseconds: 0)
  ),
  GetPage(
      name: '/Login',
      page: () => const Login(),
      binding: LoginBinding(),
      middlewares: [LoginMiddleware()],
      transitionDuration: const Duration(milliseconds: 0)
  ),
  GetPage(
      name: '/Register',
      page: () => const Register(),
      binding: RegisterBinding(),
      transitionDuration: const Duration(milliseconds: 0)
  ),
  GetPage(
      name: '/Pin',
      page: () => const Pin(),
      binding: PinBinding(),
      transitionDuration: const Duration(milliseconds: 0)
  ),
  GetPage(
      name: '/MainPage',
      page: () => const MainPage(),
      binding: MainPageBinding(),
      transitionDuration: const Duration(milliseconds: 0)
  ),
  GetPage(
      name: '/Help',
      page: () => const Help(),
      binding: HelpBinding(),
      transitionDuration: const Duration(milliseconds: 0)
  ),
  GetPage(
      name: '/Sss',
      page: () => const Sss(),
      binding: SssBinding(),
      transitionDuration: const Duration(milliseconds: 0)
  ),
  GetPage(
      name: '/ContactUs',
      page: () => const ContactUs(),
      binding: ContactUsBinding(),
      transitionDuration: const Duration(milliseconds: 0)
  ),
  GetPage(
      name: '/LegalInformation',
      page: () => const LegalInformation(),
      binding: LegalInformationBinding(),
      transitionDuration: const Duration(milliseconds: 0)
  ),
  GetPage(
      name: '/Profile',
      page: () => const Profile(),
      binding: ProfileBinding(),
      transitionDuration: const Duration(milliseconds: 0)
  ),
  GetPage(
      name: '/LegalInformationPageView',
      page: () => const LegalInformationPageView(),
      binding: LegalInformationPageViewBinding(),
      transitionDuration: const Duration(milliseconds: 0)
  ),
  GetPage(
      name: '/CallPage',
      page: () => const CallPage(),
      binding: CallBinding(),
      transitionDuration: const Duration(milliseconds: 0)
  ),
  GetPage(
      name: '/LastCall',
      page: () => const LastCall(),
      binding: LastCallBinding(),
      transitionDuration: const Duration(milliseconds: 0)
  ),
  GetPage(
      name: '/BlockedUsers',
      page: () => const BlockedUsers(),
      transitionDuration: const Duration(milliseconds: 0)
  ),
  GetPage(
      name: '/FavoriteUsers',
      page: () => const FavoriteUsers(),
      transitionDuration: const Duration(milliseconds: 0)
  ),
  GetPage(
      name: '/ReportUser',
      page: () => const ReportUser(),
      binding: ReportUserBinding(),
      transitionDuration: const Duration(milliseconds: 0)
  ),
];

