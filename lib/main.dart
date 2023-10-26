import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dropdown_alert/dropdown_alert.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'app/bindings/InitialBinding.dart';
import 'app/model/CallSystemModel.dart';
import 'app/routs/appRouts.dart';
import 'error.dart';
import 'help/FCM.dart';
import 'help/hive/localStorage.dart';
import 'help/myprovider.dart';
import 'help/translation.dart';
import 'package:uuid/uuid.dart';

//morad@ASD@123
//flutter build apk --split-per-abi
//flutter build appbundle
//flutter pub run flutter_launcher_icons:main
//flutter pub pub run flutter_native_splash:create

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(message)async{
  await Firebase.initializeApp();
  CallSystemModel().showCallkitIncoming(const Uuid().v4());
}








void main()async{
  WidgetsFlutterBinding.ensureInitialized();

  /// Firebase
  FCM().initialize();
  // await Firebase.initializeApp();
  // FCM fcm = FCM();
  // fcm.initialize();
  // FirebaseMessaging.instance;
  // await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
  //   alert: true,
  //   badge: true,
  //   sound: true,
  // );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  /// Firebase
  // await Firebase.initializeApp();
  // FirebaseMessaging.instance;
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // FCM fcm = FCM();
  // fcm.initialize();

  /// Hive
  final Directory appDocumentDirectory = await getApplicationDocumentsDirectory();
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
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context)=> AtlasPortProvider(),
    builder: (context, _){
    return GetMaterialApp(
      title: 'Zebra',
      initialRoute: '/Login',
      initialBinding: InitialBinding(),
      debugShowCheckedModeBanner: false,
      getPages: appRoutes(),
      translations: TRANSLATION(),
      locale: LocalStorage().getValue("locale") == null ? const Locale('en') : Locale(LocalStorage().getValue("locale")),
      fallbackLocale: LocalStorage().getValue("locale") == null ? const Locale('en') : Locale(LocalStorage().getValue("locale")),
      theme: ThemeData(
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
          fontFamily: LocalStorage().getValue("locale") == 'tr' ? "Century" : "Century",
      ),
      builder: (context,widget) {
        ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
          Clipboard.setData(ClipboardData(text: "$errorDetails"));
          return CustomError(errorDetails: errorDetails);
        };
        return Stack(
          children: [
            widget!,
            const DropdownAlert()
          ],
        );
      },
    );
    }
    );
  }
}



