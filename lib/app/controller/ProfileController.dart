import 'dart:convert';

import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dropdown_alert/alert_controller.dart';
import 'package:flutter_dropdown_alert/model/data_alert.dart';
import 'package:get/get.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zebra/app/Repository/UserInfoApi.dart';
import '../../help/hive/localStorage.dart';
import '../../help/loadingClass.dart';
import '../Repository/AuthApi.dart';
import '../model/ItemModel.dart';
import '../model/UserInfoModel.dart';
import '../model/countryCodes.dart';
import '../../help/globals.dart' as globals;



class ProfileController extends GetxController with StateMixin<UserInfoModel> ,LoadingDialog{
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController phoneNumberController;
  late TextEditingController emailAddressController;
  late TextEditingController birthdayController;
  var viewPassword = true;
  var viewPassword2 = true;
  RxInt selectedIndex = 2.obs;
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
  RxBool phoneError = false.obs;
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




  updateApi(){
    FocusManager.instance.primaryFocus?.unfocus();
    if(formState.currentState!.validate()){
      if(selectedIndex.value == 2){
        AlertController.show("Update Account", "Please select a gender !", TypeAlert.warning);
      }else if(birthdayController.text.isEmpty){
        AlertController.show("Update Account", "Lütfen doğum tarihini giriniz !", TypeAlert.warning);
      } else{
        showDialogBox();
        Map profileData = {
          "email": emailAddressController.text.isEmpty ? '' : emailAddressController.text,
          "gender": selectedIndex.value,
          "birthDate": birthdayController.text
        };
        UserInfoApi().updateApi(formData: profileData).then((value){
          hideDialog();
          AlertController.show("Update Account", "Profil bilgileri başarıyla değiştirildi", TypeAlert.success);
          Get.back();
        },onError: (e){
          hideDialog();
        });
      }
    }else{}
  }


  deleteUser(context){
    showDialogBox();
    UserInfoApi().deleteUserApi().then((value){
      hideDialog();
      if(value){
        LocalStorage().setValue("login",false);
        Get.offAllNamed("/Login");
        QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          text: 'We are wait you again!',
        );
      }
    },onError: (e){
      AlertController.show("Delete Account", "Your account has not been deleted, please try again", TypeAlert.warning);
      Get.back();
      hideDialog();
    });
  }


  getInfo(){
    showDialogBox();
    UserInfoApi().getUserInfo().then((value){
      change(value,status: RxStatus.success());
      firstNameController = TextEditingController(text: value.data.user.firstName);
      lastNameController = TextEditingController(text: value.data.user.lastName);
      phoneNumberController = TextEditingController(text: value.data.user.phone.toString().replaceAll("+90", ""));
      birthdayController = TextEditingController(text: value.data.user.birthDate);
      emailAddressController = TextEditingController(text: value.data.user.email);
      selectedIndex.value = value.data.user.gender!;
      hideDialog();
    },onError: (e){
      hideDialog();
    });
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
    phoneNumberController = TextEditingController();
    birthdayController = TextEditingController();
    emailAddressController =TextEditingController();
    super.onInit();
    codeList.value = codes;
  }


  @override
  void onReady() {
    super.onReady();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkState.value = false;
      checkState2.value = false;
      getInfo();
    });
  }



  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneNumberController.dispose();
    emailAddressController.dispose();
    super.dispose();
  }




}