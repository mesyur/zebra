import 'package:get/get.dart';
import '../controller/InitialController.dart';

class InitialBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<InitialController>(()=> InitialController());
  }
}