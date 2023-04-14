import 'package:get/get.dart';
import 'InitialController.dart';
import 'package:zebra/help/globals.dart' as globals;



class CallWaitingController extends GetxController{
  InitialController initialController = Get.find();

  sendCansel(){
    globals.haveCall = false;
    Get.back();
  }

  // @override
  // void onReady() {
  //   initialController.socket.on("callAccepted",(data){
  //     print(data);
  //     print("--****---****----******--");
  //     globals.callOpen = true;
  //     Get.toNamed('/CallPage',arguments: [{"socketChannel": data["data"]['socketChannelRandom']},{"id": ""},{"name": data["data"]['name']}]);
  //   });
  //   super.onReady();
  // }


}







