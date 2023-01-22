import 'package:get/get.dart';
import '../controller/LegalInformationPageViewController.dart';


class LegalInformationPageViewBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<LegalInformationPageViewController>(()=> LegalInformationPageViewController());
  }
}