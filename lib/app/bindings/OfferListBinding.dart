import 'package:get/get.dart';
import '../controller/ChatController.dart';
import '../controller/ChatMainController.dart';
import '../controller/OfferListController.dart';


class OfferListBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<OfferListController>(()=> OfferListController());
  }
}