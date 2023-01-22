import 'package:get/get.dart';
import '../controller/LegalInformationController.dart';


class LegalInformationBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<LegalInformationController>(()=> LegalInformationController());
  }
}