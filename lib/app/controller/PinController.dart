import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:custom_timer/custom_timer.dart';
import 'package:device_info/device_info.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dropdown_alert/alert_controller.dart';
import 'package:flutter_dropdown_alert/model/data_alert.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zebra/help/hive/localStorage.dart';
import '../../help/loadingClass.dart';
import '../Repository/AuthApi.dart';
import '../model/ItemModel.dart';
import '../model/countryCodes.dart';

class PinController extends GetxController with StateMixin ,LoadingDialog{



  final Color accentColor = const Color(0xFFFFFFFF);
  String deviceName = '';
  String deviceModel = '';
  String systemName = '';
  String systemVersion = '';
  RxString pinCode = ''.obs;
  RxBool checkActive = false.obs;
  final CustomTimerController timerController = CustomTimerController();
  int? userId;
  RxString from = ''.obs;





  getDeviceInfo()async{
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    if(GetPlatform.isIOS){
      IosDeviceInfo iosDeviceInfo = await deviceInfoPlugin.iosInfo;
      deviceName = iosDeviceInfo.name;
      deviceModel = iosDeviceInfo.model;
      systemName = iosDeviceInfo.systemName;
      systemVersion = iosDeviceInfo.systemVersion;
    }else if(GetPlatform.isAndroid){
      AndroidDeviceInfo androidDeviceInfo = await deviceInfoPlugin.androidInfo;
      deviceName = androidDeviceInfo.brand;
      deviceModel = androidDeviceInfo.model;
      systemName = androidDeviceInfo.product;
      systemVersion = androidDeviceInfo.version.release;
    }
  }


  loginApi(){
    FocusManager.instance.primaryFocus?.unfocus();
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    showDialogBox();
    AuthApi().pinApi(pin: pinCode.value,userId: userId).then((value){
      if(value.data.user.deviceData.isEmpty){
        AuthApi().deviceRegisterApi(
          userId: userId,
          fcmToken: "xxx",
          brand: deviceName,
          model: deviceModel,
          os: systemName
        ).then((valueDeviceRegister){
          firebaseMessaging.subscribeToTopic("${valueDeviceRegister.data.user.id}");
          LocalStorage().setValue("login", true);
          LocalStorage().setValue("id", valueDeviceRegister.data.user.id);
          LocalStorage().setValue("firstName", valueDeviceRegister.data.user.firstName);
          LocalStorage().setValue("lastName", valueDeviceRegister.data.user.lastName);
          LocalStorage().setValue("phone", valueDeviceRegister.data.user.phone);
          LocalStorage().setValue("userType", valueDeviceRegister.data.user.userType);
          LocalStorage().setValue("email", valueDeviceRegister.data.user.email);
          LocalStorage().setValue("gender", valueDeviceRegister.data.user.gender);
          LocalStorage().setValue("token", value.data.user.token);
          hideDialog();
          Get.toNamed('/MainPage');
        },onError: (e){
          hideDialog();
          AlertController.show("Error", "Error try again", TypeAlert.error);
        });
      }else{
        firebaseMessaging.subscribeToTopic("${value.data.user.id}");
        print('----------------- | ${value.data.user.id}');
        LocalStorage().setValue("login", true);
        LocalStorage().setValue("id", value.data.user.id);
        LocalStorage().setValue("firstName", value.data.user.firstName);
        LocalStorage().setValue("lastName", value.data.user.lastName);
        LocalStorage().setValue("phone", value.data.user.phone);
        LocalStorage().setValue("userType", value.data.user.userType);
        LocalStorage().setValue("email", value.data.user.email);
        LocalStorage().setValue("gender", value.data.user.gender);
        LocalStorage().setValue("token", value.data.user.token);
        hideDialog();
        Get.toNamed('/MainPage');
      }
    },onError: (e){
      hideDialog();
      AlertController.show("Error", "Error try again", TypeAlert.error);
    });
    }


  resendPin(){
    timerController.reset();
    timerController.start();
  }


  @override
  void onInit() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Color(0xffffffff),
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    userId = Get.arguments[0]["userId"];
    from.value = Get.arguments[1]["from"];
    super.onInit();
    timerController.start(disableNotifyListeners: true);
  }


  @override
  void onReady() {
    super.onReady();
    getDeviceInfo();
  }


  @override
  void dispose() {
    timerController.dispose();
    super.dispose();
  }


}