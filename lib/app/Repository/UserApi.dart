import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:zebra/help/hive/localStorage.dart';
import '../model/DeviceRegisterModel.dart';
import '../model/PinModel.dart';
import '../model/RegisterModel.dart';
import '../model/UserInfoModel.dart';
import '../model/UserUpdateModel.dart';
import '../url/url.dart';

class UserInfoApi{
  Dio dio = Dio();
  Future<UserInfoModel> getUserInfo()async{
    dio.options.baseUrl = Urls.appApiBaseUrl;
    dio.options.receiveTimeout = const Duration(seconds: 5);
    dio.options.connectTimeout = const Duration(seconds: 10);
    dio.options.headers["authorization"] = "Bearer ${LocalStorage().getValue("token")}";
    dio.options.method = "POST";
    dio.options.headers["Accept"] = "application/json";
    dio.options.headers["Content-Type"] = "application/json";
    dio.options.responseType = ResponseType.json;
    try{
      var response = await dio.request("/user/info");
      if(response.statusCode == 200) {
        if (response.data["status"]) {
          return UserInfoModel.fromJson(response.data);
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



  Future<PinModel> pinApi({pin,userId})async{
    dio.options.baseUrl = Urls.appApiBaseUrl;
    dio.options.receiveTimeout = const Duration(seconds: 5);
    dio.options.connectTimeout = const Duration(seconds: 10);
    dio.options.method = "POST";
    dio.options.headers["Accept"] = "application/json";
    dio.options.headers["Content-Type"] = "application/json";
    dio.options.responseType = ResponseType.json;
    Map formData = {
      "pin": pin,
      "userId": userId
    };
    try{
      var response = await dio.request("/auth/pin/control",data: json.encode(formData));
      if(response.statusCode == 200){
        if(response.data["status"]){
            return PinModel.fromJson(response.data);
        }else{
          return Future.error("\nيرجى اعادة المحاولة من جديد");
        }
      }else{
        return Future.error("\nيرجى اعادة المحاولة من جديد");
      }
    }on DioError catch(e){
      return Future.error("\nيرجى اعادة المحاولة من جديد");
    }
  }



  Future<DeviceRegisterModel> deviceRegisterApi({userId,fcmToken,model,os,brand})async{
    dio.options.baseUrl = Urls.appApiBaseUrl;
    dio.options.receiveTimeout = const Duration(seconds: 5);
    dio.options.connectTimeout = const Duration(seconds: 10);
    dio.options.method = "POST";
    dio.options.headers["Accept"] = "application/json";
    dio.options.headers["Content-Type"] = "application/json";
    dio.options.responseType = ResponseType.json;
    Map formData = {
      "userId": userId,
      "fcmToken": fcmToken,
      "model": model,
      "os": os,
      "brand": brand
    };
    try{
      var response = await dio.request("/auth/register/device",data: json.encode(formData));
      if(response.statusCode == 200){
        if(response.data["status"]){
          return DeviceRegisterModel.fromJson(response.data);
        }else{
          return Future.error("\nيرجى اعادة المحاولة من جديد");
        }
      }else{
        return Future.error("\nيرجى اعادة المحاولة من جديد");
      }
    }on DioError catch(e){
      return Future.error("\nيرجى اعادة المحاولة من جديد");
    }
  }



  Future<RegisterModel> registerApi({firstName,lastName,phone})async{
    dio.options.baseUrl = Urls.appApiBaseUrl;
    dio.options.receiveTimeout = const Duration(seconds: 5);
    dio.options.connectTimeout = const Duration(seconds: 10);
    dio.options.method = "POST";
    dio.options.headers["Accept"] = "application/json";
    dio.options.headers["Content-Type"] = "application/json";
    dio.options.responseType = ResponseType.json;
    Map formData = {
      "firstName": firstName,
      "lastName": lastName,
      "phone": phone,
      "privacyPolicy": 1,
      "userType": 0,
      "userAgreement": 1
    };
    try{
      var response = await dio.request("/auth/register",data: json.encode(formData));
      if(response.statusCode == 200){
        if(response.data["status"]){
          return RegisterModel.fromJson(response.data);
        }else{
          return Future.error("");
        }
      }else{
        return Future.error("");
      }
    }on DioError catch(e){
      return Future.error("");
    }
  }









}
