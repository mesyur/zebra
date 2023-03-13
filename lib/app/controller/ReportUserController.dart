import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropdown_alert/alert_controller.dart';
import 'package:flutter_dropdown_alert/model/data_alert.dart';
import 'package:get/get.dart';
import '../../help/loadingClass.dart';
import '../Repository/CallApi.dart';
import '../model/ComplaintsModel.dart';
import '../model/ItemModel.dart';

class ReportUserController extends GetxController with StateMixin<ComplaintsModel> ,LoadingDialog{


  GlobalKey<FormState> formState = GlobalKey<FormState>();
  late TextEditingController noteController;
  late List<ItemModel> menuItems;
  final CustomPopupMenuController customPopupMenuController = CustomPopupMenuController();
  RxBool noteError = false.obs;
  RxInt selectedIndex = 99999999.obs;
  RxInt selectedIndexId = 99999999.obs;
  RxInt complainedUserId = 0.obs;





  getComplaints(){
    showDialogBox();
    CallApi().getComplaintsApi().then((value){
      change(value,status: RxStatus.success());
      hideDialog();
    },onError: (e){
      hideDialog();
    });
  }


  reportUser(){
    if(selectedIndexId.value == 99999999 || complainedUserId.value == 0){
      AlertController.show("Error", "please select from complaints...", TypeAlert.warning);
    }else if(complainedUserId.value == 0){
      AlertController.show("Error", "no user selected...", TypeAlert.warning);
    }else{
      showDialogBox();
      CallApi().addComplaintApi(
        comment: noteController.text,
        complaintId: selectedIndexId.value,
        complainedUserId: complainedUserId.value
      ).then((value){
        AlertController.show("Done", "Şikayet başarıyla gönderildi...", TypeAlert.success);
        hideDialog();
        hideDialog();
      },onError: (e){
        hideDialog();
      });
    }
  }




  @override
  void onInit() {
    noteController = TextEditingController();
    super.onInit();
    complainedUserId.value = Get.arguments;
  }

  @override
  void onReady() {
    super.onReady();
    getComplaints();
  }


  @override
  void dispose() {
    noteController.dispose();
    super.dispose();
  }

}