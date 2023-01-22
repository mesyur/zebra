import 'package:advanced_icon/advanced_icon.dart';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../controller/RegisterController.dart';
import '../../../model/ItemModel.dart';
import 'RegisterIso/RegisterIso.dart';





class Register extends GetView<RegisterController>{
  const Register({super.key});

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
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: GestureDetector(
                          onTap: (){
                            Get.back();
                          },
                          child: const Icon(Icons.arrow_back_ios)),
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
                    //  const Text("New Account", style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 25.0)),
                    //  const SizedBox(height: 5),
                      const Text("Kayıt için bilgilerini tamamla", textAlign: TextAlign.center, style: TextStyle(color: Colors.black54, fontWeight: FontWeight.normal, fontSize: 12.0)),
                      const SizedBox(height: 25),

                      Form(
                        key: controller.formState,
                        child: Obx(() => Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 25),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [


                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black12),
                                      borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                      ),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0xff512E70).withOpacity(0.0),
                                          offset: const Offset(0.0, 0.5), //(x,y)
                                          blurRadius: 5,
                                        ),
                                      ],
                                    ),
                                    height: 50,
                                    child: TextFormField(
                                      onTap: (){
                                        controller.firstNameError.value = false;
                                      },
                                      controller: controller.firstNameController,
                                      textAlignVertical: TextAlignVertical.center,
                                      cursorColor: const Color(0xFF26242e),
                                      style: const TextStyle(fontWeight: FontWeight.normal,fontSize: 15,letterSpacing: 0,color: Color(0xff363636)),
                                      validator: (value){
                                        if(value!.isEmpty){
                                          controller.menuItems0 = [ItemModel('Error First Name !', Icons.verified_user_outlined)];
                                          controller.firstNameError.value = true;
                                          return "";
                                        }else{
                                          return null;
                                        }
                                      },
                                      decoration: InputDecoration(
                                          hintStyle: const TextStyle(fontSize: 12,),
                                          errorStyle: const TextStyle(height: 0.001,color: Colors.transparent),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8),
                                            borderSide: const BorderSide(
                                              width: 0,
                                              style: BorderStyle.none,
                                            ),
                                          ),
                                          suffixIcon: const Icon(Icons.phone_enabled, color: Colors.transparent,),
                                          prefixIcon: controller.firstNameError.value ? CustomPopupMenu(
                                              menuBuilder: () => ClipRRect(
                                                borderRadius: BorderRadius.circular(5),
                                                child: Container(
                                                  color: const Color(0xFF4C4C4C),
                                                  child: IntrinsicWidth(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                                      children: controller.menuItems0.map((item) => GestureDetector(
                                                        behavior: HitTestBehavior.translucent,
                                                        onTap: () {
                                                          controller.controller0.hideMenu();
                                                        },
                                                        child: Container(
                                                          height: 40,
                                                          padding: const EdgeInsets.symmetric(horizontal: 20),
                                                          child: Row(
                                                            children: <Widget>[
                                                              Icon(item.icon, size: 15, color: Colors.white),
                                                              Expanded(
                                                                child: Container(
                                                                  margin: const EdgeInsets.only(left: 10),
                                                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                                                  child: Text(item.title, style: const TextStyle(color: Colors.white, fontSize: 12)),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      ).toList(),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              pressType: PressType.singleClick,
                                              verticalMargin: -17,
                                              controller: controller.controller0,
                                              child: Container(
                                                padding: const EdgeInsets.all(3),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: const [
                                                    SizedBox(
                                                        height: 12,
                                                        width: 12,
                                                        child: Image(image: AssetImage("assets/icons/error.gif"),)),
                                                  ],
                                                ),
                                              )) : null,
                                          hintText: 'First Name',
                                          fillColor: const Color(0xffffffff),
                                          filled: true
                                      ),
                                    ),
                                  ),


                                  const SizedBox(height: 10),

                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black12),
                                      borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                      ),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0xff512E70).withOpacity(0.0),
                                          offset: const Offset(0.0, 0.5), //(x,y)
                                          blurRadius: 5,
                                        ),
                                      ],
                                    ),
                                    height: 50,
                                    child: TextFormField(
                                      onTap: (){
                                        controller.lastNameError.value = false;
                                      },
                                      controller: controller.lastNameController,
                                      textAlignVertical: TextAlignVertical.center,
                                      cursorColor: const Color(0xFF26242e),
                                      style: const TextStyle(fontWeight: FontWeight.normal,fontSize: 15,letterSpacing: 0,color: Color(0xff363636)),
                                      validator: (value){
                                        if(value!.isEmpty){
                                          controller.menuItems1 = [
                                            ItemModel('Error Last Name !', Icons.verified_user_outlined),
                                          ];
                                          controller.lastNameError.value = true;
                                          return "";
                                        }else{
                                          return null;
                                        }
                                      },
                                      decoration: InputDecoration(
                                          hintStyle: const TextStyle(fontSize: 12,),
                                          errorStyle: const TextStyle(height: 0.001,color: Colors.transparent),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8),
                                            borderSide: const BorderSide(
                                              width: 0,
                                              style: BorderStyle.none,
                                            ),
                                          ),
                                          suffixIcon: const Icon(Icons.phone_enabled, color: Colors.transparent,),
                                          prefixIcon: controller.lastNameError.value ? CustomPopupMenu(
                                              menuBuilder: () => ClipRRect(
                                                borderRadius: BorderRadius.circular(5),
                                                child: Container(
                                                  color: const Color(0xFF4C4C4C),
                                                  child: IntrinsicWidth(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                                      children: controller.menuItems1.map((item) => GestureDetector(
                                                        behavior: HitTestBehavior.translucent,
                                                        onTap: () {
                                                          controller.controller1.hideMenu();
                                                        },
                                                        child: Container(
                                                          height: 40,
                                                          padding: const EdgeInsets.symmetric(horizontal: 20),
                                                          child: Row(
                                                            children: <Widget>[
                                                              Icon(item.icon, size: 15, color: Colors.white),
                                                              Expanded(
                                                                child: Container(
                                                                  margin: const EdgeInsets.only(left: 10),
                                                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                                                  child: Text(item.title, style: const TextStyle(color: Colors.white, fontSize: 12)),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      ).toList(),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              pressType: PressType.singleClick,
                                              verticalMargin: -17,
                                              controller: controller.controller1,
                                              child: Container(
                                                padding: const EdgeInsets.all(0),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: const [
                                                    SizedBox(
                                                        height: 12,
                                                        width: 12,
                                                        child: Image(image: AssetImage("assets/icons/error.gif"))),
                                                  ],
                                                ),
                                              )) : null,
                                          hintText: 'Last Name',
                                          fillColor: const Color(0xffffffff),
                                          filled: true
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
                      ),



                      const SizedBox(height: 30),
                      Obx(() => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 35),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                InkWell(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: (){
                                    controller.checkState.value = !controller.checkState.value;
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 2),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.black54),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(5),
                                        topRight: Radius.circular(5),
                                        bottomLeft: Radius.circular(5),
                                        bottomRight: Radius.circular(5),
                                      ),
                                    ),
                                    child: AdvancedIcon(
                                      secondaryIcon: Icons.add, //change this icon as per your requirement.
                                      icon: Icons.check, //change this icon as per your requirement.
                                      state: !controller.checkState.value ? AdvancedIconState.secondary : AdvancedIconState.primary,
                                      secondaryColor: Colors.transparent,
                                      size: 18,
                                      effect: AdvancedIconEffect.bubbleFade, //change effect as per your requirement.
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'agree for ',
                                        style: const TextStyle(color: Colors.black54,fontFamily: "Tajawal",fontSize: 12,fontWeight: FontWeight.w700),
                                        recognizer: TapGestureRecognizer()..onTap = () {
                                          controller.checkState.value = !controller.checkState.value;
                                        },
                                      ),
                                      TextSpan(
                                          text: 'flutter developer',
                                          style: const TextStyle(color: Colors.black54,fontFamily: "Tajawal",fontSize: 12,decoration: TextDecoration.underline),
                                          recognizer:  TapGestureRecognizer()..onTap = () {
                                            controller.launched = controller.launchInWebViewWithoutDomStorage(controller.toLaunch);
                                          }
                                      ),
                                    ],
                                  ),
                                ),

                              ],
                            ),

                            const SizedBox(height: 20),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                InkWell(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: (){
                                    controller.checkState2.value = !controller.checkState2.value;
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 2),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.black54),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(5),
                                        topRight: Radius.circular(5),
                                        bottomLeft: Radius.circular(5),
                                        bottomRight: Radius.circular(5),
                                      ),
                                    ),
                                    child: AdvancedIcon(
                                      secondaryIcon: Icons.add, //change this icon as per your requirement.
                                      icon: Icons.check, //change this icon as per your requirement.
                                      state: !controller.checkState2.value ? AdvancedIconState.secondary : AdvancedIconState.primary,
                                      secondaryColor: Colors.transparent,
                                      size: 18,
                                      effect: AdvancedIconEffect.bubbleFade, //change effect as per your requirement.
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'by clicking agree for ',
                                        style: const TextStyle(color: Colors.black54,fontFamily: "Tajawal",fontSize: 12,fontWeight: FontWeight.w700),
                                        recognizer: TapGestureRecognizer()..onTap = () {
                                          controller.checkState2.value = !controller.checkState2.value;
                                        },
                                      ),
                                      TextSpan(
                                          text: 'hi flutter devloper',
                                          style: const TextStyle(color: Colors.black54,fontFamily: "Tajawal",fontSize: 12,decoration: TextDecoration.underline),
                                          recognizer:  TapGestureRecognizer()..onTap = () {
                                            controller.launched = controller.launchInWebViewWithoutDomStorage(controller.toLaunch);
                                          }
                                      ),
                                    ],
                                  ),
                                ),

                              ],
                            ),
                          ],
                        ),
                      )),








                      const SizedBox(height: 40),
                      SizedBox(
                        width: 150,
                        height: 50,
                        child: MaterialButton(
                          elevation: 0,
                          onPressed: (){
                            controller.registerApi();
                          },
                          color: Colors.white,
                          shape: const RoundedRectangleBorder(
                              side: BorderSide(color: Colors.black12),
                              borderRadius: BorderRadius.all(Radius.circular(10.0))
                          ),
                          child: const Padding(
                            padding: EdgeInsets.only(top: 0),
                            child: Text('Register', style: TextStyle(color: Colors.black87, fontSize: 20.0, fontWeight: FontWeight.bold),),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                    ],
                  ),
                )
              ],
            ),
          ),
          // Positioned(
          //   bottom: 40,
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     children: [
          //       const Text('By clicking on Register an account, you agree to',style: TextStyle(fontWeight: FontWeight.normal,fontSize: 12,letterSpacing: 0,color: Colors.black54)),
          //       const SizedBox(width: 5,),
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         crossAxisAlignment: CrossAxisAlignment.center,
          //         children: const [
          //           Text('privacy policy',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,letterSpacing: 0,color: Colors.black54,decoration: TextDecoration.underline)),
          //           Text(' & ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,letterSpacing: 0,color: Colors.black54)),
          //           Text('Terms and Conditions',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,letterSpacing: 0,color: Colors.black54,decoration: TextDecoration.underline)),
          //         ],
          //       )
          //     ],
          //   ),
          // ),


          const Positioned(
              bottom: 10,
              child: Text('Zebra Version 1.0.1',style: TextStyle(color: Colors.black26),))
        ],
      ),
    );
  }
}




