import '../../../help/globals.dart' as globals;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';
import '../../../help/hive/localStorage.dart';
import '../../controller/MainPageController.dart';
import '../WIDGETS/mapPin.dart';



class MainPage extends GetView<MainPageController>{
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          key: controller.key,
          drawer: Container(
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
                          color: Colors.black.withOpacity(0.2),
                        )
                      ]),
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

                                  Column(
                                    children: [
                                      GestureDetector(
                                        onTap: (){
                                          Get.toNamed('/Profile');
                                        },
                                        child: const Row(
                                          children: [
                                            Icon(Icons.person_outlined),
                                            SizedBox(width: 10),
                                            Text("My Profile",style: TextStyle(fontSize: 15,color: Colors.black,letterSpacing: 2.5,fontWeight: FontWeight.bold))
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      GestureDetector(
                                        onTap: (){
                                          Get.toNamed('/LastCall');
                                        },
                                        child: const Row(
                                          children: [
                                            Icon(Icons.av_timer_outlined),
                                            SizedBox(width: 10),
                                            Text("Last Calls",style: TextStyle(fontSize: 15,color: Colors.black,letterSpacing: 2.5,fontWeight: FontWeight.bold))
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      GestureDetector(
                                        onTap: (){
                                          Get.toNamed('/LastDeals');
                                        },
                                        child: const Row(
                                          children: [
                                            Icon(Icons.handshake_outlined),
                                            SizedBox(width: 10),
                                            Text("Last Deals",style: TextStyle(fontSize: 15,color: Colors.black,letterSpacing: 2.5,fontWeight: FontWeight.bold))
                                          ],
                                        ),
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
                                        child: const Row(
                                          children: [
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
                                        height: 40,
                                        color: Colors.transparent,
                                        margin: const EdgeInsets.only(bottom: 20),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            const Column(
                                              children: [
                                                 Image(image: AssetImage('assets/app/logo.png'),height: 30),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(bottom: 10),
                                                  child: InkWell(
                                                      splashColor: Colors.transparent,
                                                      highlightColor: Colors.transparent,
                                                      onTap: ()async{
                                                        var selectedLanguage = 'en';
                                                        LocalStorage().setValue("locale",selectedLanguage);
                                                        Get.updateLocale(Locale(selectedLanguage));
                                                      },
                                                      child: SizedBox(
                                                          height: 30,
                                                          child: Center(child: Text("En",style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: Get.locale?.languageCode == 'en' ? FontWeight.bold : FontWeight.w400),)))),
                                                ),
                                                const SizedBox(width: 10),
                                                Container(height: 25,width: 2,color: Colors.black12),
                                                const SizedBox(width: 10),
                                                Padding(
                                                  padding: const EdgeInsets.only(bottom: 10),
                                                  child: InkWell(
                                                      splashColor: Colors.transparent,
                                                      highlightColor: Colors.transparent,
                                                      onTap: ()async{
                                                        var selectedLanguage = 'tr';
                                                        LocalStorage().setValue("locale",selectedLanguage);
                                                        Get.updateLocale(Locale(selectedLanguage));

                                                      },
                                                      child:  SizedBox(
                                                          height: 30,
                                                          child: Center(child: Text("Tr",style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: Get.locale?.languageCode == 'tr' ? FontWeight.bold : FontWeight.w400),)))),
                                                ),
                                                const SizedBox(width: 10),
                                                Container(height: 25,width: 2,color: Colors.black12),
                                                const SizedBox(width: 10),
                                                Padding(
                                                  padding: const EdgeInsets.only(bottom: 10),
                                                  child: InkWell(
                                                      splashColor: Colors.transparent,
                                                      highlightColor: Colors.transparent,
                                                      onTap: ()async{
                                                        var selectedLanguage = 'ar';
                                                        LocalStorage().setValue("locale",selectedLanguage);
                                                        Get.updateLocale(Locale(selectedLanguage));
                                                      },
                                                      child: SizedBox(
                                                          height: 30,
                                                          child: Center(child: Text("Ar",style: TextStyle(fontFamily: 'Tajawal',color: Colors.black,fontSize: 25,fontWeight: Get.locale?.languageCode == 'ar' ? FontWeight.bold : FontWeight.w400),)))),
                                                ),
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
                  ],
                ),
              ],
            ),
          ),
          body: Stack(
            children: [


              SizedBox(
                  width: Get.width,
                  height: Get.height,
                  child: MapPicker(
                    iconWidget: const Icon(Icons.location_pin,size: 40),
                    mapPickerController: controller.mapPickerController,
                    showDot: true,
                    child: Obx(() => GoogleMap(
                      padding:  EdgeInsets.only(
                        bottom: controller.mapPaddingBottom.value,
                      ),
                      initialCameraPosition: controller.initialLocation,
                      zoomControlsEnabled: false,
                      onCameraMove: (CameraPosition position) {
                        controller.cameraPosition = position;
                      },
                      onCameraMoveStarted: () {
                        controller.mapPickerController.mapMoving();
                      },
                      onCameraIdle: (){
                        controller.mapPickerController.mapFinishedMoving();
                        try{
                          controller.cameraPosition.target.latitude == null
                              ?
                          controller.myCurrentLocation = controller.myCurrentLocation
                              :
                          controller.myCurrentLocation = LatLng(controller.cameraPosition.target.latitude, controller.cameraPosition.target.longitude);
                        }catch(e){
                          print(e);
                        }
                      },
                      onMapCreated: controller.onCreate,
                      // markers: !snapshot.hasData ? Set.of([]) : {
                      //   Marker(
                      //     markerId: MarkerId("${snapshot.data?["id"]}"),
                      //     position: LatLng(snapshot.data!["lat"],snapshot.data!["lng"]),
                      //     draggable: false,
                      //     flat: true,
                      //     anchor: const Offset(0.5, 0.5),
                      //   )
                      // },
                      markers: Set<Marker>.of(controller.markers.values),
                      myLocationEnabled: false,
                      myLocationButtonEnabled: false,
                      rotateGesturesEnabled: false,
                      mapToolbarEnabled: false,

                    )),
                  )
              ),
              /*
              Center(
                child: Obx(() => Text("Socket Connected ? ${controller.initialController.socketConnected.value}",
                  style: TextStyle(color: controller.initialController.socketConnected.value ? Colors.lightGreen:Colors.redAccent))),
              ),
               */
              // Positioned(
              //   bottom: 0,
              //   child: ShaderMask(
              //       shaderCallback: (rect) {
              //         return const LinearGradient(
              //           begin: Alignment.bottomCenter,
              //           end: Alignment.topCenter,
              //           colors: [Colors.white, Colors.transparent],
              //         ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
              //       },
              //       blendMode: BlendMode.dstIn,
              //       child: Container(
              //         color: Colors.white,
              //         width: MediaQuery.of(context).size.width,
              //         height: 120,
              //       )
              //   ),
              // ),





              Positioned(
                  bottom: 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [


                      /// My Current Location
                      GestureDetector(
                        onTap: ()=> controller.goToMyLocation(),
                        child: Container(
                          height: 40.0,
                          width: 40.0,
                          margin: const EdgeInsets.all(15),
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.all(Radius.circular(100.0),),
                          ),
                          child: const Icon(Icons.my_location,size: 25.0,color: Colors.white,),
                        ),
                      ),


                      /// Main Category
                      controller.obx((state) => Obx(() => SizedBox(
                        height: 75,
                        width: Get.width,
                        child: ListView(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          children: List.generate(state!.item1!.data.length, (index) => GestureDetector(
                            onTap: controller.selectedIndexId.value == state.item1!.data[index].id ? null : (){

                              controller.categoryRules.value = [];
                              controller.selectedIndex.value = index;
                              controller.getRules(categoryId: state.item1!.data[index].id);
                              controller.selectedIndexId.value = state.item1!.data[index].id;
                              controller.selectedSubCategoryIndex.value = 999999999;
                              controller.selectedSubCategory2Index.value = 999999999;
                              controller.selectedSubCategory3Index.value = 999999999;
                              controller.selectedSubCategoryIndexId.value = 0;
                              controller.selectedSubCategory2IndexId.value = 0;
                              controller.selectedSubCategory3IndexId.value = 0;
                              controller.mainCategoryId.value = state.item1!.data[index].id;
                              controller.getCategoryAndSubCategory2(id: state.item1!.data[index].id);
                              controller.mainCategoryName.value = state.item1!.data[index].name;
                              controller.filterMainFilter([1]);



                            },
                            child: Container(
                              height: 75,
                              width: Get.width / 2 - 0,
                              margin: const EdgeInsets.symmetric(horizontal: 2),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15),
                                ),
                                color: controller.selectedIndex.value == index ? Colors.black : const Color(0xffe6e6e6),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xff512E70).withOpacity(0.3),
                                    offset: const Offset(0.0, 0.5), //(x,y)
                                    blurRadius: 5,
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset("assets/categoryIcons/${state.item1!.data[index].slug}.png",height: 45),
                                  Text(state.item1!.data[index].name,style: TextStyle(color: controller.selectedIndex.value == index ? Colors.white : Colors.black),),

                                ],
                              ),
                            ),
                          ),
                          ),
                        ),
                      )),onLoading: Container()),



                      controller.obx((state) => Container(
                        width: Get.width,
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [


                                /// Filters
                                const SizedBox(height: 10),
                                Obx(() => SizedBox(
                                  height: 50,
                                  child: ListView(
                                    scrollDirection: Axis.horizontal,
                                    children: [for(var i = 0 ; i < controller.mainFiltersWidget2.length ; i++) controller.mainFiltersWidget2[i]],
                                  ),
                                )),







                                /// SubCategory
                                const SizedBox(height: 10),
                                Obx(() => SizedBox(
                                  height: 45,
                                  child: ListView(
                                    scrollDirection: Axis.horizontal,
                                    controller: controller.scrollController,
                                    children: List.generate(state!.item2!.data[0].subCategories.length, (index) => Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 3),
                                      child: SizedBox(
                                        height: 45,
                                        child: MaterialButton(
                                          elevation: 0,
                                          onPressed: (){
                                            controller.selectedSubCategoryIndex.value = index;
                                            controller.selectedSubCategoryIndexId.value = state.item2!.data[0].subCategories[index].id;
                                            controller.selectedSubCategory2Index.value = 999999999;
                                            controller.selectedSubCategory3Index.value = 999999999;
                                            controller.selectedSubCategory2IndexId.value = 0;
                                            controller.selectedSubCategory3IndexId.value = 0;
                                            controller.subCategoryName.value = state.item2!.data[0].subCategories[index].name;
                                            controller.getSubCategory2(id: state.item2!.data[0].subCategories[index].id);

                                            state.item3 == null ? null : state.item3!.data[0].subCategories.isEmpty ? null : controller.scrollController2.jumpTo(0);
                                          },
                                          color: controller.selectedSubCategoryIndex.value == index ? Colors.black : Colors.transparent,
                                          shape: const RoundedRectangleBorder(
                                              side: BorderSide(color: Colors.black12),
                                              borderRadius: BorderRadius.all(Radius.circular(7))
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(top: 0),
                                            child: Text(state.item2!.data[0].subCategories[index].name, style: TextStyle(color: controller.selectedSubCategoryIndex.value == index ? Colors.white : Colors.black, fontSize: 17.0, fontWeight: FontWeight.w400),),
                                          ),
                                        ),
                                      ),
                                    )),
                                  ),
                                )),


                                /// SubCategory2
                                state?.item3 == null ? Container() : state!.item3!.data[0].subCategories.isEmpty ? Container() : const SizedBox(height: 10),
                                state?.item3 == null ? Container() : state!.item3!.data[0].subCategories.isEmpty ? Container() : Column(
                                  children: [
                                    Obx(() => SizedBox(
                                      height: 45,
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        controller: controller.scrollController2,
                                        children: List.generate(state.item3!.data[0].subCategories.length, (index) => Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 3),
                                          child: SizedBox(
                                            // width: 150,
                                            height: 45,
                                            child: MaterialButton(
                                              elevation: 0,
                                              onPressed: (){
                                                controller.selectedSubCategory3Index.value = 999999999;
                                                controller.selectedSubCategory2Index.value = index;
                                                controller.selectedSubCategory2IndexId.value = state.item3!.data[0].subCategories[index].id;
                                                controller.selectedSubCategory3IndexId.value = 0;
                                              },
                                              color: controller.selectedSubCategory2Index.value == index ? Colors.black : Colors.transparent,
                                              shape: const RoundedRectangleBorder(
                                                  side: BorderSide(color: Colors.black12),
                                                  borderRadius: BorderRadius.all(Radius.circular(7))
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(top: 0),
                                                child: Text(state.item3!.data[0].subCategories[index].name, style: TextStyle(color: controller.selectedSubCategory2Index.value == index ? Colors.white : Colors.black, fontSize: 17.0, fontWeight: FontWeight.w400),),
                                              ),
                                            ),
                                          ),
                                        )),
                                      ),
                                    )),
                                    state.item3!.data[0].childCategories.isEmpty ? Container() : const SizedBox(height: 10),
                                    state.item3!.data[0].childCategories.isEmpty ? Container() : Obx(() => SizedBox(
                                      height: 45,
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        controller: controller.scrollController3,
                                        children: List.generate(state.item3!.data[0].childCategories.length, (index) => Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 3),
                                          child: SizedBox(
                                            // width: 150,
                                            height: 45,
                                            child: MaterialButton(
                                              elevation: 0,
                                              onPressed: (){
                                                controller.selectedSubCategory3Index.value = index;
                                                controller.selectedSubCategory3IndexId.value = state.item3!.data[0].childCategories[index].id;
                                              },
                                              color: controller.selectedSubCategory3Index.value == index ? Colors.black : Colors.transparent,
                                              shape: const RoundedRectangleBorder(
                                                  side: BorderSide(color: Colors.black12),
                                                  borderRadius: BorderRadius.all(Radius.circular(7))
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(top: 0),
                                                child: Text(state.item3!.data[0].childCategories[index].name, style: TextStyle(color: controller.selectedSubCategory3Index.value == index ? Colors.white : Colors.black, fontSize: 17.0, fontWeight: FontWeight.w400),),
                                              ),
                                            ),
                                          ),
                                        )),
                                      ),
                                    ))
                                  ],
                                ),
                                const SizedBox(height: 30)
                              ],
                            ),




                            /// BTN
                            controller.categoryRules.isNotEmpty ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    SizedBox(
                                      width: Get.width - 150,
                                      height: 50,
                                      child: MaterialButton(
                                        elevation: 0,
                                        onPressed: (){
                                          controller.getCallUserListApi();
                                        },
                                        color: Colors.black,
                                        shape: const RoundedRectangleBorder(
                                            side: BorderSide(color: Colors.black12),
                                            borderRadius: BorderRadius.all(Radius.circular(10.0))
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.only(top: 0),
                                          child: Text('📞   ÇAĞRI GÖNDER', style: TextStyle(color: Colors.white, fontSize: 12.0, fontWeight: FontWeight.bold),),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 23),
                                  ],
                                ),
                                Column(
                                  children: [
                                    SizedBox(
                                      width: 130,
                                      height: 50,
                                      child: MaterialButton(
                                        elevation: 0,
                                        onPressed: (){
                                          controller.getCallUserListApi2(controller.categoryRules[0].increaseAmount,controller.categoryRules[0].minLimit);
                                        },
                                        color: Colors.black,
                                        shape: const RoundedRectangleBorder(
                                            side: BorderSide(color: Colors.black12),
                                            borderRadius: BorderRadius.all(Radius.circular(10.0))
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.only(top: 0),
                                          child: Text('Teklif', style: TextStyle(color: Colors.white, fontSize: 12.0, fontWeight: FontWeight.bold),),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 23),
                                  ],
                                ),
                              ],
                            )
                                :
                            Column(
                              children: [
                                SizedBox(
                                  width: Get.width - 50,
                                  height: 50,
                                  child: MaterialButton(
                                    elevation: 0,
                                    onPressed: (){
                                      controller.getCallUserListApi();
                                    },
                                    color: Colors.black,
                                    shape: const RoundedRectangleBorder(
                                        side: BorderSide(color: Colors.black12),
                                        borderRadius: BorderRadius.all(Radius.circular(10.0))
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.only(top: 0),
                                      child: Text('📞   ÇAĞRI GÖNDER', style: TextStyle(color: Colors.white, fontSize: 12.0, fontWeight: FontWeight.bold),),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 23),
                              ],
                            ),
                          ],
                        ),
                      ),onLoading: Container()),
                    ],
                  )
              ),
              /// Open Drawer Menu
              Positioned(
                left: 20,
                top: 50,
                child: GestureDetector(
                  onTap: (){
                    controller.key.currentState?.openDrawer();
                  },
                  child: const Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(Icons.lens,color: Colors.black,size: 51),
                      Icon(Icons.lens,color: Colors.white,size: 50),
                      Icon(Icons.menu,size: 30,),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        /// Top Black Bar
        Container(
          color: Colors.black.withOpacity(0.2),
          height: 35,
          width: Get.width,
        ),
      ],
    );
  }
}