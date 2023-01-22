import 'package:get/get.dart';
import '../controller/HelpController.dart';


class HelpBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<HelpController>(()=> HelpController());
  }
}