import 'package:get/get.dart';
import '../controller/CallWaitingController.dart';


class CallWaitingBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<CallWaitingController>(()=> CallWaitingController());
  }
}