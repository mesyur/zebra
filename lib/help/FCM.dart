import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:uuid/uuid.dart';
import '../app/model/CallSystemModel.dart';
import '../help/globals.dart' as globals;

class FCM{
  Future initialize() async{
    await Firebase.initializeApp();
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
    print('********---------- | User granted permission: ${settings.authorizationStatus}');
    firebaseMessaging.getToken().then((token) async{
      print("----------TOKEN-------- $token");
      globals.fcmToken = token!;
      await firebaseMessaging.subscribeToTopic("all");
    });

    FirebaseMessaging.onMessage.listen((event) {
      CallSystemModel().showCallkitIncoming(const Uuid().v4());
    });



  }
}




// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:uuid/uuid.dart';
// import '../app/model/CallSystemModel.dart';
// import '../help/globals.dart' as globals;
//
// class FCM{
//   static FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
//   Future initialize({context}) async{
//     NotificationSettings settings = await firebaseMessaging.requestPermission(
//       alert: true,
//       announcement: false,
//       badge: true,
//       carPlay: false,
//       criticalAlert: false,
//       provisional: false,
//       sound: true,
//     );
//
//
//     firebaseMessaging.getToken().then((token) async{
//       print("----------TOKEN-------- $token");
//       globals.fcmToken = token!;
//       await firebaseMessaging.subscribeToTopic("all");
//     });
//     firebaseMessaging.onTokenRefresh.listen((newToken) {
//       // print("----------NEW TOKEN-------- $newToken");
//     });
//     FirebaseMessaging.onMessage.listen((event) {
//       CallSystemModel().showCallkitIncoming(const Uuid().v4());
//     });
//     FirebaseMessaging.onBackgroundMessage((message) => CallSystemModel().showCallkitIncoming(const Uuid().v4()));
//   }
// }