import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_dropdown_alert/dropdown_alert.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:zebra/core/env_config/env_config.dart';
import 'package:zebra/core/logger/logger.dart';
import 'package:zebra/core/routes/app_pages.dart';
import 'package:zebra/core/services/api/api_service.dart';
import 'package:zebra/core/services/auth/auth_service.dart';
import 'package:zebra/core/services/cache/cache_service.dart';
import 'package:zebra/core/services/firebase_messaging/firebase_messaging_service.dart';
import 'package:zebra/core/services/language/language_service.dart';
import 'package:zebra/core/services/package_info/package_info_service.dart';
import 'package:zebra/core/services/remote_config/remote_config_service.dart';
import 'package:zebra/core/services/secure_storage/secure_storage_service.dart';
import 'package:zebra/core/services/startup/startup_service.dart';
import 'package:zebra/core/theme/theme_service.dart';
import 'package:zebra/core/theme/themes.dart';
import 'package:zebra/generated/locales.g.dart';
import 'package:zebra/help/GetStorage.dart';
import 'package:zebra/l10n/app_localizations.dart';

import 'app/bindings/InitialBinding.dart';
import 'error.dart';
import 'firebase_options.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> initFirebase() async {
  // Firebase Setup
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  if (kDebugMode) {
    // Force disable Crashlytics collection while doing every day development.
    // Temporarily toggle this to true if you want to test crash reporting in your app.
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
  }
  // Firebase Setup
}

Future<void> initServices() async {
  try {
    AppLogger.debug('starting services ...');

    WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    HttpOverrides.global = MyHttpOverrides();
    
    AppLogger.debug('initializing GetStorage...');
    await GetStorage.init();
    box.write('userIds', []);

    // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

    AppLogger.debug('loading environment...');
    await dotenv.load(fileName: Environment.fileName);

    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    AppLogger.debug('initializing Firebase...');
    await initFirebase();
    await Get.putAsync(() => FirebaseMessagingService().init());

    AppLogger.debug('initializing Hive...');
    final Directory appDocumentDirectory =
        await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);
    await Hive.openBox('local_storage');

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Color(0xff000000),
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

    AppLogger.debug('initializing core services...');
    await Get.putAsync(() => RemoteConfigService().init());
    await Get.putAsync(() => PackageInfoService().init());
    await Get.putAsync(() => CacheService().init());
    await Get.putAsync(() => SecureStorageService().init());
    await Get.putAsync(() => ApiService().init());

    AppLogger.debug('initializing ThemeService...');
    await Get.putAsync(() => ThemeService().init());

    AppLogger.debug('initializing remaining services...');
    await Get.putAsync(() => LanguageService().init());
    await Get.putAsync(() => AuthService().init());

    await Get.putAsync(() => StartUpService().init());

    // FlutterNativeSplash.remove();

    AppLogger.debug('All services started...');
  } catch (e) {
    rethrow;
  }
}

//morad@ASD@123
//flutter build apk --split-per-abi
//flutter build appbundle
//flutter pub run flutter_launcher_icons:main
//flutter pub pub run flutter_native_splash:create

void main() async {
  try {
    await initServices();
    runApp(MyApp());
  } catch (e) {
    runApp(const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Uygulama başlatılırken hata oluştu'),
        ),
      ),
    ));
  }
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final themeService = Get.find<ThemeService>();
  final languageService = Get.find<LanguageService>();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(
          title: 'Zebra',
          getPages: AppPages.routes,
          // getPages: appRoutes(),
          initialRoute: AppPages.initial,
          enableLog: kDebugMode,
          locale: languageService.locale,
          fallbackLocale: AppLocalizations.supportedLocales.first,
          theme: Themes.light,
          darkTheme: Themes.dark,
          themeMode: themeService.themeMode,
          debugShowCheckedModeBanner: kDebugMode,
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          translationsKeys: AppTranslation.translations,
          initialBinding: InitialBinding(),

          /*  theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
            scrollbarTheme: ScrollbarThemeData(
              thumbColor: MaterialStateProperty.all(const Color(0xffc00d1e)),
              radius: const Radius.circular(10.0),
              thickness: MaterialStateProperty.all(5.0),
              minThumbLength: 50,
            ),
            useMaterial3: true,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            //  fontFamily: LocalStorage().getValue("locale") == 'tr' ? "Montserrat" : "FlatFont",
            fontFamily: "Century",
          ), */
          builder: (context, widget) {
            ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
              /* print(errorDetails);
              FirebaseCrashlytics.instance
                  .recordFlutterFatalError(errorDetails); */
              Clipboard.setData(ClipboardData(text: "$errorDetails"));
              return CustomError(errorDetails: errorDetails);
            };
            return Stack(
              children: [widget!, const DropdownAlert()],
            );
          },
        );
      },
    );
  }
}
