import 'package:get/get.dart';
import '../controller/LastCallController.dart';


class LastCallBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<LastCallController>(()=> LastCallController());
  }
}