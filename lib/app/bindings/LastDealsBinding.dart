import 'package:get/get.dart';
import '../controller/LastDealsController.dart';


class LastDealsBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<LastDealsController>(()=> LastDealsController());
  }
}