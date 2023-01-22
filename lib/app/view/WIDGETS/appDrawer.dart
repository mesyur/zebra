import 'dart:ui';
//import 'package:avatar_glow/avatar_glow.dart';
import 'package:avatar_glow/avatar_glow.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';
import '../../../help/globals.dart' as globals;
import '../../../help/hive/localStorage.dart';
import '../../../help/loadingClass.dart';
import 'LegalInformationPageView.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(horizontal: 0),
        child: Stack(
          children: [
            GestureDetector(
              onTap: (){
                Navigator.of(context).pop();
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.black12.withOpacity(0.0001),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 75,
                  height:  MediaQuery.of(context).size.height - 0,
                  margin: const EdgeInsets.symmetric(horizontal: 0),
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      blurRadius: 16,
                      spreadRadius: 16,
                      color: Colors.white.withOpacity(0.1),
                    )
                  ]),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(0.0),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 20.0,
                        sigmaY: 10.0,
                      ),
                      child: Container(
                          width: MediaQuery.of(context).size.width - 75,
                          height:  MediaQuery.of(context).size.height - 0,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(0.0),
                              border: Border.all(
                                width: 1.5,
                                color: Colors.white.withOpacity(0.3),
                              )),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [

                                  Container(
                                    width: MediaQuery.of(context).size.width - 75,
                                    margin: const EdgeInsets.only(top: 50),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text("Merhaba",style: TextStyle(fontSize: 15,color: Colors.black54,letterSpacing: 1.5,fontWeight: FontWeight.w700)),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text("${LocalStorage().getValue("firstName")} ${LocalStorage().getValue("lastName")}",style: const TextStyle(fontSize: 25,color: Colors.black,letterSpacing: 2.5,fontWeight: FontWeight.bold)),
                                            const Icon(Icons.notifications_active_outlined,size: 30,),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),


                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.center,
                                  //   crossAxisAlignment: CrossAxisAlignment.center,
                                  //   children: [
                                  //     Stack(
                                  //       alignment: Alignment.center,
                                  //       children: <Widget>[
                                  //         Container(
                                  //           padding: const EdgeInsets.all(1),
                                  //           width: 110,
                                  //           height: 110,
                                  //           child: AvatarGlow(
                                  //             glowColor: Colors.black45,
                                  //             endRadius: 130,
                                  //             duration: const Duration(milliseconds: 2000),
                                  //             repeat: true,
                                  //             showTwoGlows: true,
                                  //             repeatPauseDuration: const Duration(milliseconds: 100),
                                  //             child: Material(
                                  //               elevation: 8.0,
                                  //               shape: const CircleBorder(),
                                  //               child: Container(
                                  //                 width: 100,
                                  //                 height: 100,
                                  //                 decoration: BoxDecoration(
                                  //                   color: Colors.white,
                                  //                   image: DecorationImage(
                                  //                     image: NetworkImage(globals.profilePhoto),
                                  //                     fit: BoxFit.cover,
                                  //                   ),
                                  //                   borderRadius: const BorderRadius.all(Radius.circular(100.0)),
                                  //                   border: Border.all(
                                  //                     color: const Color(0xff000000),
                                  //                     //width: 80,
                                  //                   ),
                                  //                 ),
                                  //               ),
                                  //             ),
                                  //           ),
                                  //         ),
                                  //       ],
                                  //     ),
                                  //   ],
                                  // ),

                                  // RotatedBox(
                                  //   quarterTurns: 3,
                                  //   child: Column(
                                  //     mainAxisAlignment: MainAxisAlignment.center,
                                  //     crossAxisAlignment: CrossAxisAlignment.center,
                                  //     children: [
                                  //       const Text("globals.customer_tr",style: TextStyle(fontSize: 25,letterSpacing: 2.5,),),
                                  //       const Text("globals.customer_code",style: TextStyle(fontSize: 15,color: Color(0xffc00d1e),letterSpacing: 1.5,fontWeight: FontWeight.w700),),
                                  //       const SizedBox(height: 20,),
                                  //       Row(
                                  //         children: [
                                  //           Padding(
                                  //             padding: const EdgeInsets.all(7.0),
                                  //             child: InkWell(
                                  //               splashColor: Colors.transparent,
                                  //               highlightColor: Colors.transparent,
                                  //               onTap: ()async{
                                  //                 final link = WhatsAppUnilink(
                                  //                   phoneNumber: globals.whatsApp,
                                  //                   text: Get.locale?.languageCode == 'en' ? "Hello, I am the customer\n${globals.customer} / ${globals.customer} \nCan you help me?" : "مرحباً, معكم الزبون *${globals.customer_tr} / ${globals.customer_code}* هل يمكنكم تقديم مساعدة ؟",
                                  //                 );
                                  //                 await launch('$link');
                                  //               },
                                  //               child: const Image(image: AssetImage("assets/icons/whatsapp-button.png"),height: 40,),
                                  //             ),
                                  //           ),
                                  //         ],
                                  //       )
                                  //     ],
                                  //   ),
                                  // ),






                                  Column(
                                    children: [
                                      GestureDetector(
                                        onTap: (){
                                          Get.toNamed('/Profile');
                                        },
                                        child: Row(
                                          children: const [
                                            Icon(Icons.person_outlined),
                                            SizedBox(width: 10),
                                            Text("My Profile",style: TextStyle(fontSize: 15,color: Colors.black,letterSpacing: 2.5,fontWeight: FontWeight.bold))
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      Row(
                                        children: const [
                                          Icon(Icons.av_timer_outlined),
                                          SizedBox(width: 10),
                                          Text("Last Calls",style: TextStyle(fontSize: 15,color: Colors.black,letterSpacing: 2.5,fontWeight: FontWeight.bold))
                                        ],
                                      ),
                                      // const SizedBox(height: 20),
                                      // Row(
                                      //   children: const [
                                      //     Icon(Icons.payments_outlined),
                                      //     SizedBox(width: 10),
                                      //     Text("Payment Methods",style: TextStyle(fontSize: 15,color: Colors.black,letterSpacing: 2.5,fontWeight: FontWeight.bold))
                                      //   ],
                                      // ),
                                      const SizedBox(height: 20),
                                      GestureDetector(
                                        onTap: (){
                                          Get.toNamed('/Help');
                                        },
                                        child: Row(
                                          children: const [
                                            Icon(Icons.live_help_outlined),
                                            SizedBox(width: 10),
                                            Text("Help",style: TextStyle(fontSize: 15,color: Colors.black,letterSpacing: 2.5,fontWeight: FontWeight.bold))
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),








                                  Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(7.0),
                                            child: InkWell(
                                              splashColor: Colors.transparent,
                                              highlightColor: Colors.transparent,
                                              onTap: ()async{
                                                final link = WhatsAppUnilink(
                                                  phoneNumber: globals.whatsApp,
                                                  text: Get.locale?.languageCode == 'en' ? "Hello, I am the customer\n${LocalStorage().getValue("firstName")} ${LocalStorage().getValue("lastName")} \nCan you help me?" : "مرحباً, معكم الزبون *${LocalStorage().getValue("firstName")} ${LocalStorage().getValue("lastName")}* هل يمكنكم تقديم مساعدة ؟",
                                                );
                                                await launch('$link');
                                              },
                                              child: const Image(image: AssetImage("assets/icons/whatsapp-button.png"),height: 40,),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      const Divider(color: Colors.black12),
                                      const SizedBox(height: 10),
                                      Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: 25,
                                        color: Colors.transparent,
                                        margin: const EdgeInsets.only(bottom: 20),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            const Image(image: AssetImage('assets/app/logo.png'),height: 100),
                                            Row(
                                              children: [
                                                InkWell(
                                                    splashColor: Colors.transparent,
                                                    highlightColor: Colors.transparent,
                                                    onTap: ()async{
                                                      var selectedLanguage = 'en';
                                                      LocalStorage().setValue("locale",selectedLanguage);
                                                      Get.updateLocale(Locale(selectedLanguage));
                                                    },
                                                    child: SizedBox(
                                                        height: 25,
                                                        child: Center(child: Text("En",style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: Get.locale?.languageCode == 'en' ? FontWeight.bold : FontWeight.w400),)))),
                                                const SizedBox(width: 10),
                                                Container(height: 25,width: 2,color: Colors.black12),
                                                const SizedBox(width: 10),
                                                InkWell(
                                                    splashColor: Colors.transparent,
                                                    highlightColor: Colors.transparent,
                                                    onTap: ()async{
                                                      var selectedLanguage = 'tr';
                                                        LocalStorage().setValue("locale",selectedLanguage);
                                                        Get.updateLocale(Locale(selectedLanguage));

                                                    },
                                                    child:  SizedBox(
                                                        height: 25,
                                                        child: Center(child: Text("Tr",style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: Get.locale?.languageCode == 'tr' ? FontWeight.bold : FontWeight.w400),)))),
                                                const SizedBox(width: 10),
                                                Container(height: 25,width: 2,color: Colors.black12),
                                                const SizedBox(width: 10),
                                                InkWell(
                                                    splashColor: Colors.transparent,
                                                    highlightColor: Colors.transparent,
                                                    onTap: ()async{
                                                      var selectedLanguage = 'ar';
                                                        LocalStorage().setValue("locale",selectedLanguage);
                                                        Get.updateLocale(Locale(selectedLanguage));
                                                    },
                                                    child: Column(
                                                      children:  [
                                                        SizedBox(
                                                            height: 25,
                                                            child: Center(child: Text("Ar",style: TextStyle(fontFamily: 'Tajawal',color: Colors.black,fontSize: 25,fontWeight: Get.locale?.languageCode == 'ar' ? FontWeight.bold : FontWeight.w400),))),
                                                      ],
                                                    )),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(bottom: 0),
                                            child: Text(globals.version,style: const TextStyle(fontSize: 10,color: Colors.black26,fontWeight: FontWeight.w600),),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}