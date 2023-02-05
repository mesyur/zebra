import 'package:get/get.dart';
import '../../help/loadingClass.dart';
import '../Repository/CallApi.dart';
import '../model/LastCallModel.dart';
import 'package:intl/intl.dart' as initl;


class LastCallController extends GetxController with StateMixin<LastCallModel> ,LoadingDialog{


  RxList blockedUserList = [].obs;
  RxList favoriteUserList = [].obs;




  getLastCallUserList(){
    showDialogBox();
    CallApi().getLastCallUserListApi().then((value){
      change(value,status: RxStatus.success());
      hideDialog();
    },onError: (e){
      hideDialog();
    });
  }



  blockUnBlockUser(blockedUserId){
    showDialogBox();
    CallApi().blockUnBlockUserApi(blockedUserId: blockedUserId).then((value){
      hideDialog();
      getLastCallUserList();
    },onError: (e){
      hideDialog();
    });
  }


  unBlockedUsers(blockedUserId){
    showDialogBox();
    CallApi().blockUnBlockUserApi(blockedUserId: blockedUserId).then((value){
      blockedUserPageRefresh();
      hideDialog();
    },onError: (e){
      hideDialog();
    });
  }


  favoriteUnFavoriteUsers(callId){
    showDialogBox();
    CallApi().favoriteUnFavoriteUsers(callId: callId).then((value){
      favoriteUserPageRefresh();
      hideDialog();
    },onError: (e){
      hideDialog();
    });
  }


  blockedUser(){
    showDialogBox();
    CallApi().blockedUserApi().then((value){
      blockedUserList.value = value.data;
      hideDialog();
      Get.toNamed('/BlockedUsers')?.then((value){
        getLastCallUserList();
      });
    },onError: (e){
      hideDialog();
    });
  }


  favoriteUser(){
    showDialogBox();
    CallApi().favoriteUserApi().then((value){
      favoriteUserList.value = value.data;
      hideDialog();
      Get.toNamed('/FavoriteUsers')?.then((value){
        getLastCallUserList();
      });
    },onError: (e){
      hideDialog();
    });
  }


  blockedUserPageRefresh(){
    showDialogBox();
    CallApi().blockedUserApi().then((value){
      blockedUserList.value = value.data;
      hideDialog();
      getLastCallUserList();
    },onError: (e){
      hideDialog();
    });
  }



  favoriteUserPageRefresh(){
    showDialogBox();
    CallApi().favoriteUserApi().then((value){
      favoriteUserList.value = value.data;
      hideDialog();
      getLastCallUserList();
    },onError: (e){
      hideDialog();
    });
  }


  getDateTime({datetime}){
    var time = datetime;
    var format = initl.DateFormat('yyyy-MM-dd');
    var format2 = initl.DateFormat().add_jm();
    // print(format.format(DateTime.parse(time)));
    // print(format2.format(DateTime.parse(time)));
    return '${format.format(DateTime.parse(time))}     ${format2.format(DateTime.parse(time))}';
  }



  rateUser(ratedUserId,score){
    showDialogBox();
    CallApi().rateUserApi(ratedUserId: ratedUserId,score: score).then((value){
      hideDialog();
    },onError: (e){
      hideDialog();
    });
  }




  @override
  void onReady() {
    super.onReady();
    getLastCallUserList();
  }

}