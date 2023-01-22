import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:zebra/app/controller/LoginController.dart';
import '../../../model/ItemModel.dart';
import 'IsoLogin/IsoLogin.dart';


class Login extends GetView<LoginController>{
  const Login({super.key});

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

                     // const SizedBox(height: 50),
                    //  const Text("Welcome Again", style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 25.0)),
                     // const SizedBox(height: 5),
                   //   const Text("Enter your phone number to continue", textAlign: TextAlign.center, style: TextStyle(color: Colors.black54, fontWeight: FontWeight.normal, fontSize: 12.0)),
                      const SizedBox(height: 50),

                      Form(
                        key: controller.formState,
                        child: Obx(() => Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 25),
                              child: Stack(
                                alignment: Alignment.center,
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
                                        controller.phoneError.value = false;
                                      },
                                      controller: controller.phoneNumberController,
                                      textAlignVertical: TextAlignVertical.center,
                                      keyboardType: TextInputType.number,
                                      cursorColor: const Color(0xFF26242e),
                                      maxLength: 10,
                                      inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                                      style: const TextStyle(fontWeight: FontWeight.normal,fontSize: 15,letterSpacing: 0,color: Color(0xff363636)),
                                      onChanged: (x){
                                        x.startsWith("0") ? controller.phoneNumberController.clear() : null;
                                      },
                                      validator: (value){
                                        if(value!.isEmpty || value.length < 10){
                                          controller.menuItems = [ItemModel('Error Phone Number !', Icons.verified_user_outlined)];
                                          controller.phoneError.value = true;
                                          return "";
                                        }else{
                                          return null;
                                        }
                                      },
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8),
                                            borderSide: const BorderSide(
                                              width: 0,
                                              style: BorderStyle.none,
                                            ),
                                          ),
                                          counterText: "",
                                          hintStyle: const TextStyle(fontSize: 12,),
                                          errorStyle: const TextStyle(height: 0.001,color: Colors.transparent),
                                          suffixIcon: const Icon(Icons.phone_enabled, color: Colors.transparent,),
                                          prefixIcon: controller.phoneError.value ? CustomPopupMenu(
                                              menuBuilder: () => ClipRRect(
                                                borderRadius: BorderRadius.circular(5),
                                                child: Container(
                                                  color: const Color(0xFF4C4C4C),
                                                  child: IntrinsicWidth(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                                      children: controller.menuItems.map((item) => GestureDetector(
                                                        behavior: HitTestBehavior.translucent,
                                                        onTap: () {
                                                          controller.customPopupMenuController.hideMenu();
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
                                              controller: controller.customPopupMenuController,
                                              child: Container(
                                                padding: const EdgeInsets.all(3),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: const [
                                                     SizedBox(
                                                        height: 17,
                                                        width: 17,
                                                        child: Image(image: AssetImage("assets/icons/error.gif"),)),
                                                  ],
                                                ),
                                              )) : const Icon(Icons.phone, color: Colors.black54,size: 20,),
                                          hintText: 'Phone Number',
                                          fillColor: const Color(0xffffffff),
                                          filled: true
                                      ),
                                    ),
                                  ),

                                  Positioned(
                                    right: 10,
                                    child: GestureDetector(
                                      onTap: (){
                                        Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder: (context, animation1, animation2) {
                                              return const IsoLogin();
                                            },
                                            transitionsBuilder: (context, animation1, animation2, child) {
                                              return FadeTransition(
                                                opacity: animation1,
                                                child: child,
                                              );
                                            },
                                            transitionDuration: const Duration(microseconds: 250),
                                          ),
                                        ).then((value){
                                          SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
                                            statusBarColor: Colors.transparent,
                                            statusBarBrightness: Brightness.dark,
                                            statusBarIconBrightness: Brightness.dark,
                                            systemNavigationBarColor: Color(0xffffffff),
                                            systemNavigationBarIconBrightness: Brightness.dark,
                                          ));
                                        });
                                      },
                                      child: Container(
                                        child: controller.flagMyIso.value != '' ? Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text('${controller.dialCodeMyIso}',textDirection: TextDirection.rtl,style: const TextStyle(fontWeight: FontWeight.normal,fontSize: 12,letterSpacing: 0,color: Color(0xff363636)),strutStyle: const StrutStyle(forceStrutHeight: true,height: 1,)),
                                            const SizedBox(width: 5),
                                            Image(
                                              height: 15,
                                              image: AssetImage(controller.flagMyIso.value),
                                            ),
                                          ],
                                        ) :
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: const [
                                            Text('90+',textDirection: TextDirection.rtl,style: TextStyle(fontWeight: FontWeight.normal,fontSize: 12,letterSpacing: 0,color: Color(0xff363636)),strutStyle: StrutStyle(forceStrutHeight: true,height: 1,)),
                                            SizedBox(width: 5),
                                            Image(
                                              height: 15,
                                              image: AssetImage("assets/flags/tr.png"),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
                      ),

                      const SizedBox(height: 20),

                      const Text("Telefonunu doğrulama için sana bir SMS göndereceğiz", textAlign: TextAlign.center, style: TextStyle(color: Colors.black54, fontWeight: FontWeight.normal, fontSize: 12.0)),


                      const SizedBox(height: 40),
                      SizedBox(
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