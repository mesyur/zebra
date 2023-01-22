import 'package:get/get.dart';
import '../controller/PinController.dart';


class PinBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<PinController>(()=> PinController());
  }
}