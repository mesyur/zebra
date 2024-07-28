import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:zebra/app/controller/CallWaitingController.dart';

class CallWaiting extends GetView<CallWaitingController>{
  const CallWaiting({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFECF0F1),
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset('assets/icons/callWaiting.json',height: 250),
            const SizedBox(height: 40),
            SizedBox(
              width: 150,
              height: 50,
              child: MaterialButton(
                elevation: 0,
                onPressed: (){
                  controller.sendCansel();
                },
                color: Colors.white,
                shape: const RoundedRectangleBorder(
                    side: BorderSide(color: Colors.black12),
                    borderRadius: BorderRadius.all(Radius.circular(10.0))
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: Text('Cancel'.tr, style: const TextStyle(color: Colors.black87, fontSize: 20.0, fontWeight: FontWeight.bold),),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}