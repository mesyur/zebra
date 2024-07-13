import 'package:get/get.dart';
import '../../help/GetStorage.dart';
import '../../help/loadingClass.dart';
import '../Repository/ChatApi.dart';
import '../model/ChatListModel.dart';
import '../model/Global.dart';



class ChatMainController extends GetxController with StateMixin, LoadingDialog{

  Rxn<ChatListModel> chatListModel = Rxn<ChatListModel>();


  chatListApi(){
    showDialogBox();
    ChatApi().chatListApi().then((value){
      chatListModel.value = value;
      Get.back();
    },onError: (e){
      Get.back();
    });
  }


  @override
  void onReady() {
    super.onReady();
    chatListApi();
    change(null,status: RxStatus.success());
  }


}







