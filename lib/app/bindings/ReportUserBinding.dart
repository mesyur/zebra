import 'package:get/get.dart';
import '../controller/ReportUserController.dart';


class ReportUserBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ReportUserController>(()=> ReportUserController());
  }
}