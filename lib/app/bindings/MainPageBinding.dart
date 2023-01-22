import 'package:get/get.dart';
import '../controller/MainPageController.dart';


class MainPageBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<MainPageController>(()=> MainPageController());
  }
}