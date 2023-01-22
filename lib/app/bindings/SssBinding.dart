import 'package:get/get.dart';
import '../controller/SssController.dart';


class SssBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<SssController>(()=> SssController());
  }
}