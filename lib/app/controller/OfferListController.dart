import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../help/loadingClass.dart';
import '../Repository/OfferApi.dart';
import '../model/OfferListModel.dart';



class OfferListController extends GetxController with StateMixin, LoadingDialog{

  Rxn<OfferListModel> offerListModel = Rxn<OfferListModel>();


  getTime(time){
    String gateTimeString = time;
    DateTime gateTime = DateTime.parse(gateTimeString);
    return DateFormat('kk:mm').format(gateTime);
  }

  getDay(time){
    String gateTimeString = time;
    DateTime gateTime = DateTime.parse(gateTimeString);
    return DateFormat('yyyy-MM-dd').format(gateTime);
  }

  chatListApi(){
    showDialogBox();
    OfferApi().getOfferList().then((value){
      offerListModel.value = value;
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







