import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dropdown_alert/alert_controller.dart';
import 'package:flutter_dropdown_alert/model/data_alert.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../help/loadingClass.dart';
import '../Repository/AuthApi.dart';
import '../model/ItemModel.dart';
import '../model/countryCodes.dart';
import '../../help/globals.dart' as globals;



class RegisterController extends GetxController with StateMixin ,LoadingDialog{
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  var viewPassword = true;
  var viewPassword2 = true;
  final Color accentColor = const Color(0xFF282373);
  late List<ItemModel> menuItems0;
  late List<ItemModel> menuItems1;
  late List<ItemModel> menuItems2;
  late List<ItemModel> menuItems3;
  final CustomPopupMenuController controller0 = CustomPopupMenuController();
  final CustomPopupMenuController controller1 = CustomPopupMenuController();
  final CustomPopupMenuController controller2 = CustomPopupMenuController();
  final CustomPopupMenuController controller3 = CustomPopupMenuController();
  var selected = 0;
  RxBool lastNameError = false.obs;
  RxBool firstNameError = false.obs;
  RxList codeList = [].obs;
  Future<void>? launched;
  RxBool checkState = true.obs;
  RxBool checkState2 = true.obs;
  RxString codeMyIso = ''.obs;
  RxString dialCodeMyIso = "+90".obs;
  RxString flagMyIso = ''.obs;
  final Uri toLaunch = Uri(scheme: 'https', host: 'www.google.com', path: '');

  Future<void> launchInWebViewWithoutDomStorage(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.externalNonBrowserApplication, webViewConfiguration: const WebViewConfiguration(enableDomStorage: false))){
      throw 'Could not launch $url';
    }
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




  registerApi(){
    if(formState.currentState!.validate()){
      if(!checkState.value){
        AlertController.show("check box 1", "agree !", TypeAlert.warning);
      }else if(!checkState2.value){
        AlertController.show("check box 2", "agree !", TypeAlert.warning);
      }else{
        showDialogBox();
        AuthApi().registerApi(
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          phone: globals.globalPhoneNumberForPin
        ).then((value){
          hideDialog();
          AlertController.show("Login", "successfully registered", TypeAlert.success);
          Get.offAndToNamed('/Pin',arguments: [{"userId": value.data.user.userId},{"from": "login"}]);
        },onError: (e){
          hideDialog();
          AlertController.show("Error", "Error try again", TypeAlert.error);
        });
      }
      lastNameError.value = false;
      firstNameError.value = false;
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
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    super.onInit();
    codeList.value = codes;
  }


  @override
  void onReady() {
    super.onReady();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkState.value = false;
      checkState2.value = false;
    });
  }



  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }




}