import 'package:get/get.dart';
import '../controller/ChatController.dart';


class ChatBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ChatController>(()=> ChatController());
  }
}