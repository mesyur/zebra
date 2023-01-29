import 'package:custom_timer/custom_timer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../help/PinCodeFields.dart';
import '../../../controller/PinController.dart';
import '../../../../help/globals.dart' as globals;

class Pin extends GetView<PinController>{
  const Pin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Scaffold(
            body: ListView(
              children: [
                const SizedBox(height: 10),
                Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Icon(Icons.arrow_back_ios,color: Colors.transparent,),
                    ),
                  ],
                ),
                Align(
                  alignment: const Alignment(0,-0.1),
                  child: Column(
                    children: [
                      const SizedBox(height: 50),
                      const Image(image: AssetImage("assets/app/logo.png"),height: 55),

                      const SizedBox(height: 50),
                     // const Text("Pin Code", style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 25.0)),
                     // const SizedBox(height: 5),
                      Text("The activation code has been sent to the number\n${globals.globalPhoneNumberForPin}", textAlign: TextAlign.center, style: const TextStyle(color: Colors.black54, fontWeight: FontWeight.normal, fontSize: 12.0)),
                      const SizedBox(height: 25),



                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: CustomTimer(
                          begin: const Duration(seconds: 0),
                          end: const Duration(minutes: 3),
                          controller: controller.timerController,
                          stateBuilder: (time, state) {
                            if(state == CustomTimerState.finished) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: GestureDetector(
                                  onTap: (){
                                    controller.resendPin();
                                  },
                                  child: SizedBox(
                                    width: Get.width,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text("resend".tr,textDirection: TextDirection.rtl,style: const TextStyle(fontSize: 15,color: Colors.black87)),
                                        const SizedBox(width: 0),
                                        const Icon(Icons.arrow_forward_ios_outlined,size: 10,color: Colors.black87,),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }
                            return null;
                          },
                          builder: (time) {
                            return SizedBox(
                              width: Get.width,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${time.minutes}:${time.seconds}", style: const TextStyle(fontSize: 15,color: Colors.black87)),
                                  const SizedBox(width: 0),
                                  const Icon(Icons.arrow_forward_ios_outlined,size: 10,color: Colors.transparent,),
                                ],
                              ),
                            );
                          },
                        ),
                      ),



                      /// PIN CODE FIELDS
                      PinCodeFields(
                        length: 4,
                        fieldBorderStyle: FieldBorderStyle.Square,
                        responsive: false,
                        fieldHeight: 60,
                        fieldWidth: 60,
                        borderWidth: 0.5,
                        margin: const EdgeInsets.all(1),
                        activeBorderColor: Colors.black,
                        activeBackgroundColor: Colors.black12.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(2.0),
                        keyboardType: TextInputType.number,
                        autoHideKeyboard: false,
                        autofocus: false,
                        fieldBackgroundColor: Colors.black12.withOpacity(0.07),
                        borderColor: Colors.black54,
                        textStyle: TextStyle(fontSize: 32, fontFamily: "RobotoMono",fontWeight: FontWeight.w400,color: Colors.black.withOpacity(0.6)),
                        onComplete: (output) {
                          FocusScope.of(context).unfocus();
                          controller.pinCode.value = output;
                        },
                        onChange: (x){
                          x.length == 4 ? controller.checkActive.value = true : controller.checkActive.value = false;
                        },
                      ),

                      const SizedBox(height: 20),

                      Obx(() => controller.from.value == "login" ? Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: GestureDetector(
                            onTap: (){
                              Get.back();
                            },
                            child: const Text("Numarayı düzeltmek için tıkla !", textAlign: TextAlign.center, style: TextStyle(color: Colors.black54, fontWeight: FontWeight.normal, fontSize: 12.0,decoration: TextDecoration.underline))),
                      ) : Container()),


                      const SizedBox(height: 40),

                      const SizedBox(height: 40),
                  Obx(() =>  controller.checkActive.value ? SizedBox(
                        width: 150,
                        height: 50,
                        child: MaterialButton(
                          elevation: 0,
                          onPressed: (){
                            controller.loginApi();
                          },
                          color: Colors.white,
                          shape: const RoundedRectangleBorder(
                              side: BorderSide(color: Colors.black12),
                              borderRadius: BorderRadius.all(Radius.circular(10.0))
                          ),
                          child: const Padding(
                            padding: EdgeInsets.only(top: 0),
                            child: Text('Login', style: TextStyle(color: Colors.black87, fontSize: 20.0, fontWeight: FontWeight.bold),),
                          ),
                        ),
                      ) : Container()
                  ),

                      const SizedBox(height: 20),

                    ],
                  ),
                )
              ],
            ),
          ),
          const Positioned(
              bottom: 10,
              child: Text('Zebra Version 1.0.1',style: TextStyle(color: Colors.black26),))
        ],
      ),
    );
  }
}