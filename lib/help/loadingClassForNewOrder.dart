import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class LoadingClassForNewOrder{
  showDialogBox(){
    Get.dialog(
      barrierDismissible: false,
      useSafeArea: true,
      barrierColor: Colors.transparent,
      WillPopScope(
        onWillPop: ()async => false,
        child: Dialog(
          backgroundColor: Colors.transparent,
          child: StatefulBuilder(
              builder: (BuildContext _, StateSetter setState) {
                return Container();
              }),
        ),
      ),
    );
  }
  hideDialog(){
    Get.back();
  }
}
