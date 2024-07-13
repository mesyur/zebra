import 'dart:convert';
import 'package:dio/dio.dart';
import '../../help/hive/localStorage.dart';
import '../model/OfferListModel.dart';
import '../url/url.dart';

class OfferApi{
  Dio dio = Dio();


  Future<OfferListModel> getOfferList()async{
    dio.options.baseUrl = Urls.appApiBaseUrl;
    dio.options.receiveTimeout = const Duration(seconds: 5);
    dio.options.connectTimeout = const Duration(seconds: 10);
    dio.options.headers["authorization"] = "Bearer ${LocalStorage().getValue("token")}";
    dio.options.method = "POST";
    dio.options.headers["Accept"] = "application/json";
    dio.options.headers["Content-Type"] = "application/json";
    dio.options.responseType = ResponseType.json;
    try{
      var response = await dio.request("/offer/list",data: jsonEncode({
        "serviceId": 2
      }));
      if(response.statusCode == 200) {
        if (response.data["status"]) {
          return OfferListModel.fromJson(response.data);
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




  Future saveOffer({home,hour,serviceDate,serviceTime,note})async{
    dio.options.baseUrl = Urls.appApiBaseUrl;
    dio.options.receiveTimeout = const Duration(seconds: 5);
    dio.options.connectTimeout = const Duration(seconds: 10);
    dio.options.headers["authorization"] = "Bearer ${LocalStorage().getValue("token")}";
    dio.options.method = "POST";
    dio.options.headers["Accept"] = "application/json";
    dio.options.headers["Content-Type"] = "application/json";
    dio.options.responseType = ResponseType.json;
    try{
      var response = await dio.request("/offer/save",data: jsonEncode({
        "serviceId": 2,
        "detail": {
          "home": home,
          "hour": hour
        },
        "serviceDate": serviceDate,
        "serviceTime": serviceTime,
        "note": note
      }));
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
