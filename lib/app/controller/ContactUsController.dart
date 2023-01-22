import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../help/loadingClass.dart';
import '../Repository/ContactUsApi.dart';
import '../model/ItemModel.dart';

class ContactUsController extends GetxController with StateMixin ,LoadingDialog{
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  late TextEditingController noteController;
  late List<ItemModel> menuItems;
  final CustomPopupMenuController customPopupMenuController = CustomPopupMenuController();
  RxBool noteError = false.obs;


  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }


  contactUsApi(context){
    FocusManager.instance.primaryFocus?.unfocus();
    if(formState.currentState!.validate()){
      showDialogBox();
      ContactUsApi().sendMessage(message: noteController.text).then((value){
        hideDialog();
        if(value.status){
          QuickAlert.show(
            context: context,
            type: QuickAlertType.success,
            onConfirmBtnTap: (){
              Get.back();
              Get.back();
            },
            text: 'Mesajınız başarıyla gönderildi. En kısa sürede sizinle iletişime geçeceğiz.',
          );
        }else{
          QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            title: 'Oops...',
            text: 'Mesaj gönderilemedi ! Lütfen tekrar deneyin',
          );
        }
      },onError: (e){
        hideDialog();
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: 'Oops...',
          text: 'Mesaj gönderilemedi ! Lütfen tekrar deneyin',
        );
      });
    }else{}
  }



  @override
  void onInit() {
    noteController = TextEditingController();
    super.onInit();
  }


  @override
  void dispose() {
    noteController.dispose();
    super.dispose();
  }

}