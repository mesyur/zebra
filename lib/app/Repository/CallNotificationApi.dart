import 'dart:convert';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:zebra/help/hive/localStorage.dart';


class CallNotificationApi{
  Dio dio = Dio();
  Future callUserById({userId,socketChannel,callerId,callerName})async{
    dio.options.receiveTimeout = 5000;
    dio.options.connectTimeout = 10000;
    dio.options.headers["authorization"] = "key=AAAA7fbubQE:APA91bHo2hVnySaQuNtlcsifjPnhyhP7aiVTl3QqP7ZPdSCIF4dbsaOCwBK2KEQKSXYjget7iV8Vf0iEbxSRipLgJYYoq8KYq1Q5dZ7eHGY44mqLJifhUz7M8reG8oCBCbrCT4tsTV8a";
    dio.options.method = "POST";
    dio.options.headers["Accept"] = "application/json";
    dio.options.headers["Content-Type"] = "application/json";
    dio.options.responseType = ResponseType.json;
    var favMap = json.encode({
      "priority": "HIGH",
      "data": {
        "title": "",
        "body": "",
        "callData": {
          "socketChannel": socketChannel,
          "callerId": callerId,
          "callerName": callerName
        },
        "click_action": "FLUTTER_NOTIFICATION_CLICK"
      },
      "to": "/topics/$userId",
      "content_available": false,
      "apns-priority": 5
    });
    try{
      var response = await dio.request("https://fcm.googleapis.com/fcm/send",data: favMap);
      if(response.statusCode == 200) {
        return response.data;
      }else{
        return Future.error("\nيرجى اعادة المحاولة من جديد");
      }
    }on DioError catch(e){
      return Future.error("\nيرجى اعادة المحاولة من جديد");
    }
  }
}