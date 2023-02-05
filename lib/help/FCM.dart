import 'package:firebase_messaging/firebase_messaging.dart';
import '../help/globals.dart' as globals;

class FCM{
  static FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  Future initialize({context}) async{
    await firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    ).then((value){
    });
    firebaseMessaging.getToken().then((token) async{
      //  print("----------TOKEN-------- $token");
      globals.fcmToken = token!;
      await firebaseMessaging.subscribeToTopic("all");
    });
    firebaseMessaging.onTokenRefresh.listen((newToken) {
      // print("----------NEW TOKEN-------- $newToken");
    });
    FirebaseMessaging.onMessage.listen((event) {
      print(event.notification?.title);
    });
  }
}