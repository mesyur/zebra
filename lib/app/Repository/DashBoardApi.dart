import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import '../../help/globals.dart' as globals;
import '../url/url.dart';

class DashboardDetails{
  Dio dio = Dio();
  Future dashboardDetails()async{
    dio.options.baseUrl = Urls.appApiBaseUrl;
    dio.options.receiveTimeout = 5000;
    dio.options.connectTimeout = 10000;
    String basicAuth = 'Basic ${base64Encode(utf8.encode('mobileapp:2a0p1p9@'))}';
    dio.options.headers = <String, String>{'authorization': basicAuth};
    dio.options.headers["authorization"] = "Bearer ${globals.token}";
    dio.options.method = "POST";
    dio.options.headers["Accept"] = "application/json";
    dio.options.headers["Content-Type"] = "application/json";
    dio.options.responseType = ResponseType.json;
    Map formData = {
      "customer": globals.customer.toString(),
      "customerRecodDate": 1,
      "instantCurrent": 1,
      "lastReceivedGoods": 1,
      "lastShipment": 1,
      "lastCollection": 1,
      "mostPopularCompany": 1,
      "chartShipping": 1
    };
    try{
      var response = await dio.request("/v2/mobile/customer/details",data: json.encode(formData));
      if(response.statusCode == 200){
        if(response.data["result"] == "succces"){
          // providerValue.globalDashboardDetails = response.data;
          // providerValue.globalDashboardDetailsCampaigns = response.data["campaigns"];
           globals.whatsApp = response.data["whatsappNumber"];
          // globals.chatActive = response.data["chatActive"];
          // globals.makeOrderActive = response.data["makeOrderActive"];
          return response.data;
        }else{
          /// TODO go to login X-token
          Get.offAllNamed("/MainLoginPage");
          return Future.error("\nيرجى اعادة المحاولة من جديد");
        }
      }else{
        /// TODO go to login X-token
        Get.offAllNamed("/MainLoginPage");
        return Future.error("\nيرجى اعادة المحاولة من جديد");
      }
    }on DioError catch(e){
      /// TODO go to login X-token
      Get.offAllNamed("/MainLoginPage");
      return Future.error("\nيرجى اعادة المحاولة من جديد");
    }
  }


  Future campaignsClose({loginMap})async{
    dio.options.baseUrl = Urls.appApiBaseUrl;
    dio.options.receiveTimeout = 5000;
    dio.options.connectTimeout = 10000;
    String basicAuth = 'Basic ${base64Encode(utf8.encode('mobileapp:2a0p1p9@'))}';
    dio.options.headers = <String, String>{'authorization': basicAuth};
    dio.options.headers["authorization"] = "Bearer ${globals.token}";
    dio.options.method = "POST";
    dio.options.headers["Accept"] = "application/json";
    dio.options.headers["Content-Type"] = "application/json";
    dio.options.responseType = ResponseType.json;
    Map formData = loginMap;
    try{
      var response = await dio.request("/mobile/campaign/read",data: json.encode(formData));
      if(response.statusCode == 200){
        return response.data;
      }else{
        return false;
      }
    }on DioError catch(e){
      return false;
    }
  }


}
