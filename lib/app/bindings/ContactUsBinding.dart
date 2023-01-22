import 'package:get/get.dart';
import '../controller/ContactUsController.dart';


class ContactUsBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ContactUsController>(()=> ContactUsController());
  }
}