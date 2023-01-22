// import 'package:firebase_messaging/firebase_messaging.dart';
// import '../help/globals.dart' as globals;
//
// class FCM{
//   static FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
//   Future initialize({context}) async{
//     firebaseMessaging.getToken().then((token) async{
//       print("----------TOKEN-------- $token");
//       //globals.fcmToken = token;
//       await firebaseMessaging.subscribeToTopic("all");
//     });
//     firebaseMessaging.onTokenRefresh.listen((newToken) {
//       // print("----------NEW TOKEN-------- $newToken");
//     });
//   }
// }