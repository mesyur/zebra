import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:zebra/app/model/CallSystemModel.dart';
import 'package:zebra/core/logger/logger.dart';

class FirebaseMessagingService extends GetxService {
  late final String? fcmToken;

  Future<FirebaseMessagingService> init() async {
    await initialize();
    return this;
  }

  Future<void> initialize() async {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    NotificationSettings settings = await firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (Platform.isIOS) {
      final apnsToken = await FirebaseMessaging.instance.getAPNSToken();
      if (apnsToken == null) {
        // APNS token is available, make FCM plugin API requests...
        return;
      }
    }

    fcmToken = await FirebaseMessaging.instance.getToken();

    AppLogger.debug("FCM Token: $fcmToken");

/*     firebaseMessaging.getToken().then((token) async {
      print("----------TOKEN-------- $token");
      globals.fcmToken = token!;
      await firebaseMessaging.subscribeToTopic("all");
    }); */

    FirebaseMessaging.onMessage.listen((event) {
      AppLogger.debug("event: ${event.toMap().toString()}");
      // CallSystemModel().showCallkitIncoming(const Uuid().v4());
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (message.data['type'] == 'call') {
    CallSystemModel().showCallkitIncoming(const Uuid().v4());
  }

  AppLogger.debug("event: ${message.toMap().toString()}");
  // await Firebase.initializeApp();
  // CallSystemModel().showCallkitIncoming(const Uuid().v4());
}
