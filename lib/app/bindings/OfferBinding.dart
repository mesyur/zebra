import 'package:get/get.dart';
import '../controller/OfferController.dart';


class OfferBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<OfferController>(()=> OfferController());
  }
}