import 'package:get/get.dart';
import '../controller/ProfileController.dart';


class ProfileBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(()=> ProfileController());
  }
}