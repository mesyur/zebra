import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:zebra/help/globals.dart' as globals;
import 'package:uuid/uuid.dart';
import '../model/SocketModel.dart';
import '../view/Offer/AcceptOffers.dart';
import 'InitialController.dart';






class OfferController extends GetxController with GetSingleTickerProviderStateMixin{


  InitialController initialController = Get.find();
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
  RxInt selectedHomeRoomIndex = 9999.obs;
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
  }


  @override
  void onClose() {
    noteController.dispose();
    super.onClose();
  }


}