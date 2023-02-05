import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:zebra/help/hive/localStorage.dart';
import '../model/BlockedUserModel.dart';
import '../model/CallUserListModel.dart';
import '../model/FavoriteListModel.dart';
import '../model/LastCallModel.dart';
import '../url/url.dart';

class CallApi{
  Dio dio = Dio();


  Future<CallUserListModel> getCallUserListApi({callUserListMap})async{
    dio.options.baseUrl = Urls.appApiBaseUrl;
    dio.options.receiveTimeout = 5000;
    dio.options.connectTimeout = 10000;
    dio.options.headers["authorization"] = "Bearer ${LocalStorage().getValue("token")}";
    dio.options.method = "POST";
    dio.options.headers["Accept"] = "application/json";
    dio.options.headers["Content-Type"] = "application/json";
    dio.options.responseType = ResponseType.json;
    try{
      var response = await dio.request("/call/user/list",data: jsonEncode(callUserListMap));
      if(response.statusCode == 200) {
        if (response.data["status"]) {
          return CallUserListModel.fromJson(response.data);
        } else {
          return Future.error("\nيرجى اعادة المحاولة من جديد");
        }
      }else{
        return Future.error("\nيرجى اعادة المحاولة من جديد");
      }
    }on DioError catch(e){
      return Future.error("\nيرجى اعادة المحاولة من جديد");
    }
  }


  Future favoriteUnFavoriteUsers({callId})async{
    dio.options.baseUrl = Urls.appApiBaseUrl;
    dio.options.receiveTimeout = 5000;
    dio.options.connectTimeout = 10000;
    dio.options.headers["authorization"] = "Bearer ${LocalStorage().getValue("token")}";
    dio.options.method = "POST";
    dio.options.headers["Accept"] = "application/json";
    dio.options.headers["Content-Type"] = "application/json";
    dio.options.responseType = ResponseType.json;
    Map favMap = {
      "callId": callId
    };
    try{
      var response = await dio.request("/call/favorite",data: jsonEncode(favMap));
      if(response.statusCode == 200) {
        if (response.data["status"]) {
          return true;
        } else {
          return Future.error("\nيرجى اعادة المحاولة من جديد");
        }
      }else{
        return Future.error("\nيرجى اعادة المحاولة من جديد");
      }
    }on DioError catch(e){
      return Future.error("\nيرجى اعادة المحاولة من جديد");
    }
  }


  Future<FavoriteListModel> favoriteUserApi()async{
    dio.options.baseUrl = Urls.appApiBaseUrl;
    dio.options.receiveTimeout = 5000;
    dio.options.connectTimeout = 10000;
    dio.options.headers["authorization"] = "Bearer ${LocalStorage().getValue("token")}";
    dio.options.method = "POST";
    dio.options.headers["Accept"] = "application/json";
    dio.options.headers["Content-Type"] = "application/json";
    dio.options.responseType = ResponseType.json;
    try{
      var response = await dio.request("/call/favorite/list");
      if(response.statusCode == 200) {
        if (response.data["status"]) {
          return FavoriteListModel.fromJson(response.data);
        } else {
          return Future.error("\nيرجى اعادة المحاولة من جديد");
        }
      }else{
        return Future.error("\nيرجى اعادة المحاولة من جديد");
      }
    }on DioError catch(e){
      return Future.error("\nيرجى اعادة المحاولة من جديد");
    }
  }



  Future<LastCallModel> getLastCallUserListApi()async{
    dio.options.baseUrl = Urls.appApiBaseUrl;
    dio.options.receiveTimeout = 5000;
    dio.options.connectTimeout = 10000;
    dio.options.headers["authorization"] = "Bearer ${LocalStorage().getValue("token")}";
    dio.options.method = "GET";
    dio.options.headers["Accept"] = "application/json";
    dio.options.headers["Content-Type"] = "application/json";
    dio.options.responseType = ResponseType.json;
    try{
      var response = await dio.request("/call/recent");
      if(response.statusCode == 200) {
        if (response.data["status"]) {
          return LastCallModel.fromJson(response.data);
        } else {
          return Future.error("\nيرجى اعادة المحاولة من جديد");
        }
      }else{
        return Future.error("\nيرجى اعادة المحاولة من جديد");
      }
    }on DioError catch(e){
      return Future.error("\nيرجى اعادة المحاولة من جديد");
    }
  }




  Future blockUnBlockUserApi({blockedUserId})async{
    dio.options.baseUrl = Urls.appApiBaseUrl;
    dio.options.receiveTimeout = 5000;
    dio.options.connectTimeout = 10000;
    dio.options.headers["authorization"] = "Bearer ${LocalStorage().getValue("token")}";
    dio.options.method = "POST";
    dio.options.headers["Accept"] = "application/json";
    dio.options.headers["Content-Type"] = "application/json";
    dio.options.responseType = ResponseType.json;
    Map blockMap = {
      "blockedUserId": blockedUserId
    };
    try{
      var response = await dio.request("/user/block",data: jsonEncode(blockMap));
      if(response.statusCode == 200) {
        if (response.data["status"]) {
          return true;
        } else {
          return Future.error("\nيرجى اعادة المحاولة من جديد");
        }
      }else{
        return Future.error("\nيرجى اعادة المحاولة من جديد");
      }
    }on DioError catch(e){
      return Future.error("\nيرجى اعادة المحاولة من جديد");
    }
  }







  Future<BlockedUserModel> blockedUserApi()async{
    dio.options.baseUrl = Urls.appApiBaseUrl;
    dio.options.receiveTimeout = 5000;
    dio.options.connectTimeout = 10000;
    dio.options.headers["authorization"] = "Bearer ${LocalStorage().getValue("token")}";
    dio.options.method = "POST";
    dio.options.headers["Accept"] = "application/json";
    dio.options.headers["Content-Type"] = "application/json";
    dio.options.responseType = ResponseType.json;
    try{
      var response = await dio.request("/user/block/list");
      if(response.statusCode == 200) {
        if (response.data["status"]) {
          return BlockedUserModel.fromJson(response.data);
        } else {
          return Future.error("\nيرجى اعادة المحاولة من جديد");
        }
      }else{
        return Future.error("\nيرجى اعادة المحاولة من جديد");
      }
    }on DioError catch(e){
      return Future.error("\nيرجى اعادة المحاولة من جديد");
    }
  }




  Future rateUserApi({ratedUserId,score})async{
    dio.options.baseUrl = Urls.appApiBaseUrl;
    dio.options.receiveTimeout = 5000;
    dio.options.connectTimeout = 10000;
    dio.options.headers["authorization"] = "Bearer ${LocalStorage().getValue("token")}";
    dio.options.method = "POST";
    dio.options.headers["Accept"] = "application/json";
    dio.options.headers["Content-Type"] = "application/json";
    dio.options.responseType = ResponseType.json;
    Map rateMap = {
      "ratedUserId": ratedUserId,
      "score": score
    };
    try{
      var response = await dio.request("/user/rate",data: jsonEncode(rateMap));
      if(response.statusCode == 200) {
        if (response.data["status"]) {
          return true;
        } else {
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
