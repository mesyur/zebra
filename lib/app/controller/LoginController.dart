import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dropdown_alert/alert_controller.dart';
import 'package:flutter_dropdown_alert/model/data_alert.dart';
import 'package:get/get.dart';
import '../../help/loadingClass.dart';
import '../Repository/AuthApi.dart';
import '../model/ItemModel.dart';
import '../model/countryCodes.dart';
import '../../help/globals.dart' as globals;

class LoginController extends GetxController with StateMixin ,LoadingDialog{


  late List<ItemModel> menuItems;
  final CustomPopupMenuController customPopupMenuController = CustomPopupMenuController();
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  late TextEditingController phoneNumberController;
  var viewPassword = true;
  final Color accentColor = const Color(0xFFFFFFFF);
  RxBool phoneError = false.obs;
  RxList codeList = [].obs;
  RxString codeMyIso = ''.obs;
  RxString dialCodeMyIso = "+90".obs;
  RxString flagMyIso = ''.obs;
  String deviceName = '';
  String deviceModel = '';
  String systemName = '';
  String systemVersion = '';

  deletePhoneError(){
    phoneError.value = false;
  }

  buildSearchList(String userSearchTerm) {
    List<Map<String, String>> results = [];
    if(userSearchTerm.isEmpty) {
      codeList.value = codes;
    }else{
      for(var i in codes){
        i['name']!.toLowerCase().contains(userSearchTerm.toLowerCase()) ? results.add(i) : null;
      }
      codeList.value = results;
    }
  }






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

      // print(androidDeviceInfo);
      // print(androidDeviceInfo.androidId);
      // print(androidDeviceInfo.board);
      // print(androidDeviceInfo.bootloader);
      // print(androidDeviceInfo.device);
      // print(androidDeviceInfo.display);
      // print(androidDeviceInfo.fingerprint);
      // print(androidDeviceInfo.hardware);
      // print(androidDeviceInfo.host);
      // print(androidDeviceInfo.id);
      // print(androidDeviceInfo.isPhysicalDevice);
      // print(androidDeviceInfo.manufacturer);
      // print(androidDeviceInfo.supported32BitAbis);
      // print(androidDeviceInfo.supported64BitAbis);
      // print(androidDeviceInfo.supportedAbis);
      // print(androidDeviceInfo.systemFeatures);
      // print(androidDeviceInfo.tags);

    }
  }


  loginApi(){
    FocusManager.instance.primaryFocus?.unfocus();
    if(formState.currentState!.validate()){
      globals.globalPhoneNumberForPin = dialCodeMyIso+phoneNumberController.text;
      showDialogBox();
      phoneError.value = false;
      AuthApi().loginApi(phone: dialCodeMyIso+phoneNumberController.text).then((value){
        hideDialog();
        if(value.data.page == "pin"){
          Get.toNamed('/Pin',arguments: [{"userId": value.data.user?.id},{"from": "login"}]);
        }else{
          Get.toNamed('/Register');
        }
      },onError: (e){
        hideDialog();
        AlertController.show("Error", "Error try again", TypeAlert.error);
      });
    }else{}
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
    phoneNumberController = TextEditingController();
    super.onInit();
    codeList.value = codes;
  }

  @override
  void dispose() {
    phoneNumberController.dispose();
    super.dispose();
  }


  @override
  void onReady() {
    super.onReady();
    getDeviceInfo();
  }


}
