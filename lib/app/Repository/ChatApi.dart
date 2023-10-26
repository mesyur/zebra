import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:zebra/help/hive/localStorage.dart';
import '../model/ContacUsModel.dart';
import '../model/DeviceRegisterModel.dart';
import '../model/PinModel.dart';
import '../model/RegisterModel.dart';
import '../url/url.dart';

class ChatApi{
  Dio dio = Dio();


  Future<ContactUsModel> sendMessage({id,firstName,lastName,createdAt,uId,userId,text,type,})async{
    dio.options.baseUrl = Urls.appApiBaseUrl;
    dio.options.receiveTimeout = const Duration(seconds: 5);
    dio.options.connectTimeout = const Duration(seconds: 10);
    dio.options.headers["authorization"] = "Bearer ${LocalStorage().getValue("token")}";
    dio.options.method = "POST";
    dio.options.headers["Accept"] = "application/json";
    dio.options.headers["Content-Type"] = "application/json";
    dio.options.responseType = ResponseType.json;
    Map formData = {
      "author": {
        "id": id, // sender id / my id
        "firstName": firstName,
        "lastName": lastName,
        "imageUrl": "https://i.ibb.co/jWh4nty/appLogo.png",
        "createdAt": createdAt
      },
      "id": uId,
      "userId": userId, // other user id
      "text": text,
      "type": type,
      "createdAt": createdAt
    };
    try{
      var response = await dio.request("/user/chat/send/message",data: json.encode(formData));
      if(response.statusCode == 200) {
        if (response.data["status"]) {
          return ContactUsModel.fromJson(response.data);
        } else {
          return Future.error("\nيرجى اعادة المحاولة من جديد");
        }
      }else{
        return Future.error("\nيرجى اعادة المحاولة من جديد");
      }
    }on DioError catch(e){
      print(e.response);
      return Future.error("\nيرجى اعادة المحاولة من جديد");
    }
  }




}
