import 'package:get/get.dart';
import '../controller/ChatController.dart';
import '../controller/ChatMainController.dart';


class ChatMainBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ChatMainController>(()=> ChatMainController());
  }
}