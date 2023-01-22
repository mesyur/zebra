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
    dio.options.receiveTimeout = 5000;
    dio.options.connectTimeout = 10000;
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

  Future<UserUpdateModel> updateApi({formData})async{
    dio.options.baseUrl = Urls.appApiBaseUrl;
    dio.options.receiveTimeout = 5000;
    dio.options.connectTimeout = 10000;
    dio.options.headers["authorization"] = "Bearer ${LocalStorage().getValue("token")}";
    dio.options.method = "POST";
    dio.options.headers["Accept"] = "application/json";
    dio.options.headers["Content-Type"] = "application/json";
    dio.options.responseType = ResponseType.json;
    try{
      var response = await dio.request("/user/update",data: json.encode(formData));
      if(response.statusCode == 200){
        if(response.data["status"]){
          return UserUpdateModel.fromJson(response.data);
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



  Future deleteUserApi()async{
    dio.options.baseUrl = Urls.appApiBaseUrl;
    dio.options.receiveTimeout = 5000;
    dio.options.connectTimeout = 10000;
    dio.options.headers["authorization"] = "Bearer ${LocalStorage().getValue("token")}";
    dio.options.method = "POST";
    dio.options.headers["Accept"] = "application/json";
    dio.options.headers["Content-Type"] = "application/json";
    dio.options.responseType = ResponseType.json;
    try{
      var response = await dio.request("/user/delete");
      if(response.statusCode == 200){
        if(response.data["status"]){
          return true;
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


}
