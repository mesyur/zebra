import 'package:get/get.dart';
import '../controller/CallController.dart';


class CallBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<CallController>(()=> CallController());
  }
}