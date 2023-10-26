import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_dropdown_alert/alert_controller.dart';
import 'package:flutter_dropdown_alert/model/data_alert.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as ii;
import 'package:lottie/lottie.dart';
import 'package:zebra/help/globals.dart' as globals;
import 'package:uuid/uuid.dart';
import '../../help/hive/localStorage.dart';
import '../Repository/CallApi.dart';
import '../Repository/CallNotificationApi.dart';
import '../model/OpenConversionModel.dart';
import '../model/SocketModel.dart';
import '../view/Offer/AcceptOffers.dart';
import 'InitialController.dart';
import 'MainPageController.dart';






class OfferController extends GetxController with GetSingleTickerProviderStateMixin{

  late OpenConversionModel oCM;
  InitialController initialController = Get.find();
  MainPageController mainPageController = Get.find();
  late TextEditingController noteController;
  late SocketModel newData;
  RxString t2 = ''.obs;
  List callUserData = [];
  RxMap incomingNewOffers = {}.obs;
  int increaseDecreasePrice = 0;
  RxInt startPriceOrg = 0.obs;
  RxInt startPrice = 0.obs;
  RxInt currentPrice = 0.obs;
  String currentUuid = const Uuid().v4();
  DateTime selectedDate = DateTime.now();
  RxInt currentDateSelectedIndex = 0.obs;
  RxInt currentDar = DateTime.now().add(const Duration(days: 0)).day.obs;
  RxInt selectedLessonIndex = 0.obs;
  RxInt changer = 0.obs;
  RxInt selectedHomeRoomIndex = 0.obs;
  List cleanTimeText = ['3 Sat' , '4 Sat' , '5 Sat' , '6 Sat' , '7 Sat' , '8 Sat'];
  List homeRomsText = ['1+0' , '1+1' , '2+1' , '3+1' , '4+1'];
  String selectedDay = '';
  List<String> listOfMonths = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];
  List<String> listOfDays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
  RxBool conversionClosed = false.obs;


  sendOffer(){
    currentUuid = const Uuid().v4();
    currentPrice.value = startPrice.value;
    incomingNewOffers.clear();
    initialController.socket.emit('offer',[{
      "idList": callUserData,
      "price": startPrice.value,
      "homeRomsText": selectedHomeRoomIndex.value == 9999 ? '' : homeRomsText[selectedHomeRoomIndex.value],
      "cleanTimeText": cleanTimeText[selectedLessonIndex.value],
      "selectedDay": selectedDay,
      "t2": t2.value,
      "increaseDecreasePrice": increaseDecreasePrice,
      "noteText": noteController.text,
      "currentUuid": currentUuid,
      "userData": initialController.userData,
    }]);
    globals.acceptOffers = true;
    Get.to(const AcceptOffers());
  }


  onChangeDay(){
    changer.value = 1;
    const oneSec = Duration(milliseconds: 150);
    Timer.periodic(oneSec, (Timer t){
      t.cancel();
      changer.value = 0;
    });
  }



  callApi({userId,callerId,name}){
    //showDialogBox();
    mainPageController.callId.clear();
    const String chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    final Random rnd = Random();
    String getRandomString(int length) => String.fromCharCodes(Iterable.generate(length, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));
    String socketChannelRandom = getRandomString(15);
    CallApi().callUserApi(categoryId: mainPageController.mainCategoryId.value,calledUserId: userId).then((value){
      mainPageController.callId.add({userId: value.data.callId});
    CallNotificationApi().callUserById(
        userId: userId,
        catName: mainPageController.mainCategoryName.value,
        subCatName: mainPageController.subCategoryName.value,
        callerId: callerId,
        callerName: LocalStorage().getValue("firstName") + ' ' + LocalStorage().getValue("lastName"),
        socketChannel: socketChannelRandom
    );
    },onError: (e){});
    globals.haveCall = true;
    Get.toNamed('/CallWaiting');
  }



  showChoseDialogForOffer({OpenConversionModel? dialogOCM})async{
    globals.conversionOpen = true;
    await FlutterRingtonePlayer.play(fromAsset: "assets/connected.mp3", looping: false, asAlarm: false,volume: 10);
    Get.dialog(
      barrierDismissible: false,
      useSafeArea: false,
      WillPopScope(
        onWillPop: ()async => false,
        child: Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.zero,
          child: StatefulBuilder(
              builder: (BuildContext _, StateSetter setState) {
                return Center(
                  child: Container(
                    width: Get.width,
                    height: Get.height,
                    decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(0))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Center(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black,
                                      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(7),
                                      ),
                                    ),
                                    onPressed: ()async{
                                       globals.conversionOpen = false;
                                       conversionClosed.value = false;
                                       initialController.socket.emit("closedConversion",[{
                                         'id': dialogOCM?.data.zebraProviderUserId
                                       }]);
                                      Get.back();
                                    },
                                    child: const Text("Close",textDirection: TextDirection.ltr,style: TextStyle(fontWeight: FontWeight.normal,fontSize: 15,letterSpacing: 1.5,color: Colors.white),strutStyle: StrutStyle(forceStrutHeight: true,height: 1,)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Obx(() => conversionClosed.value ? Center(
                            child: Card(
                              surfaceTintColor: Colors.white,
                              child: SizedBox(
                                height: 120,
                                width: Get.width - 150,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 75,
                                      //width: 50,
                                      child: Lottie.asset(
                                        'assets/icons/warning.json',
                                        height: 75,
                                        animate: true,
                                        repeat: true,
                                      ),
                                    ),
                                    const Text("User Closed Conversion ..!",style: TextStyle(color: Colors.redAccent,fontSize: 15,fontWeight: FontWeight.bold,fontFamily: 'Montserrat')),
                                  ],
                                ),
                              ),
                            ),
                          ) : SizedBox(
                            width: Get.width,
                            child: Lottie.asset('assets/icons/servicesX.json',height: 150),
                          )),
                          const SizedBox(height: 20),
                          Center(child: Text('${dialogOCM?.data.zebraProviderUserFirstName} ${dialogOCM?.data.zebraProviderUserListName}',style: const TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold))),
                          const Divider(),
                          Text('Price : ₺${dialogOCM?.data.price}',style: const TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold,fontFamily: 'Montserrat')),
                          const Divider(),
                          Text('Hour : ${dialogOCM?.data.cleanTimeText}',style: const TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold)),
                          const Divider(),
                          Text('Day : ${dialogOCM?.data.selectedDay}',style: const TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold)),
                          const Divider(),
                          Text('Time : ${dialogOCM?.data.t2}',style: const TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold)),
                          const Divider(),
                          const SizedBox(height: 10),
                          Text('Note : ${dialogOCM?.data.noteController}',style: const TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold)),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.black,
                                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                  ),
                                  onPressed: ()async{
                                    callApi(userId: dialogOCM?.data.zebraProviderUserId,callerId: dialogOCM?.data.zebraUserData.user.id,name: '');
                                  },
                                  child: const Text("📞 Arama",textDirection: TextDirection.ltr,style: TextStyle(fontWeight: FontWeight.normal,fontSize: 15,letterSpacing: 1.5,color: Colors.white),strutStyle: StrutStyle(forceStrutHeight: true,height: 1,)),
                                ),
                              ),
                              const SizedBox(width: 20),
                              Center(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.black,
                                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                  ),
                                  onPressed: ()async{
                                    Get.toNamed('/ChatPage',arguments: dialogOCM?.data.zebraProviderUserId);
                                  },
                                  child: const Text("mesajlaşma",textDirection: TextDirection.ltr,style: TextStyle(fontWeight: FontWeight.normal,fontSize: 15,letterSpacing: 1.5,color: Colors.white),strutStyle: StrutStyle(forceStrutHeight: true,height: 1,)),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }




  @override
  void onInit() {
    callUserData = Get.arguments[0];
    increaseDecreasePrice = Get.arguments[1];
    startPrice.value = Get.arguments[2];
    startPriceOrg.value = Get.arguments[2];
    noteController = TextEditingController();
    selectedDay = '${DateTime.now().add(const Duration(days: 0)).day}/${DateTime.now().add(const Duration(days: 0)).month}'.toString();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    initialController.socket.on('acceptOffer', (data)async{
      print("==--=-==-=-=-=-=-=-=-=-=-");
      print(data);
      newData = SocketModel.fromJson(data);
      if(globals.acceptOffers){
        if(currentUuid == newData.data.currentUuid){
          await FlutterRingtonePlayer.stop();
          await FlutterRingtonePlayer.play(fromAsset: "assets/acceptOffer.mp3", looping: false, asAlarm: false,volume: 10);
          incomingNewOffers[newData.data.userData.id] = newData;
        }
      }else{
        newData = SocketModel.fromJson(data);
        initialController.socket.emit("offerCanceled",[{
          'id': newData.data.userData.id
        }]);
      }
    });


    initialController.socket.on('openConversion', (data)async{
      oCM = OpenConversionModel.fromJson(data);
      showChoseDialogForOffer(dialogOCM: oCM);
    });

    initialController.socket.on('offerCanceled', (data)async{
      if(globals.conversionOpen){
        Get.back();
        globals.conversionOpen = false;
      }
      AlertController.show("Offer", "Offer Canceled !", TypeAlert.warning);
    });



    initialController.socket.on('closedConversion', (data)async{
      if(globals.conversionOpen){
        conversionClosed.value = true;
        await FlutterRingtonePlayer.play(fromAsset: "assets/close.mp3", looping: false, asAlarm: false,volume: 10);
      }
    });



  }


  @override
  void onClose() {
    noteController.dispose();
    super.onClose();
  }


}