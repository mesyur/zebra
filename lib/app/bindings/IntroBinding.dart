import 'package:get/get.dart';
import '../controller/IntroController.dart';


class IntroBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<IntroController>(()=> IntroController());
  }
}