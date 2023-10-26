import 'package:flutter_dropdown_alert/alert_controller.dart';
import 'package:flutter_dropdown_alert/model/data_alert.dart';
import 'package:get/get.dart';
import '../../help/loadingClass.dart';
import '../Repository/CallApi.dart';
import '../model/DealsModel.dart';
import 'package:intl/intl.dart' as initl;


class LastDealsController extends GetxController with StateMixin<DealsModel> ,LoadingDialog{


  RxList blockedUserList = [].obs;
  RxList favoriteUserList = [].obs;




  getLastCallUserList(){
    showDialogBox();
    CallApi().callDealApi().then((value){
      change(value,status: RxStatus.success());
      hideDialog();
    },onError: (e){
      hideDialog();
    });
  }





  rateUser(ratedUserId,score,comment,dealDate){
    showDialogBox();
    CallApi().rateAndTakeWorkUserApi(ratedUserId: ratedUserId,score: score,comment: comment,dealDate: dealDate).then((value){
      hideDialog();
      AlertController.show("Rate", "work deal successfully Rated", TypeAlert.success);
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


  @override
  void onReady() {
    super.onReady();
    getLastCallUserList();
  }

}