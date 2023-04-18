import 'dart:math';
import 'package:zebra/help/globals.dart' as globals;
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../controller/OfferController.dart';
import '../../model/SocketModel.dart';
import 'Widgets/TimerWidget.dart';


class AcceptOffers extends GetView<OfferController>{
  const AcceptOffers({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        globals.acceptOffers = false;
        if(controller.incomingNewOffers.isNotEmpty){
          for(var i = 0 ; i < controller.incomingNewOffers.length ; i++){
            controller.initialController.socket.emit("offerCanceled",[{
            'id': controller.incomingNewOffers[controller.incomingNewOffers.keys.elementAt(i)].data.userData.id
            }]);
          }
        }else{}
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: GestureDetector(
              onTap: (){
                var rng = Random();
                var xx = rng.nextInt(100);
                controller.incomingNewOffers[xx] = SocketModel.fromJson({
                  "data": {
                    "id": 1,
                    "price": 100,
                    "homeRomsText": "2+1",
                    "cleanTimeText": "3 Sat",
                    "selectedDay": "16/4",
                    "t2": "02:00:00 PM",
                    "currentUuid": "4bf5e972-7073-498a-8395-ca0c5a5d2651",
                    "userData": {
                      "id": 23,
                      "identityNumber": "56465446",
                      "firstName": "xxxxxxx",
                      "lastName": "$xx",
                      "email": null,
                      "phone": "+905398238762",
                      "gender": 1,
                      "birthDate": null,
                      "isCitizen": 2,
                      "isActive": 1
                    }
                  }
                });
              },
              child: const Text("New Offers", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20))),
          centerTitle: true,
          surfaceTintColor: Colors.white,
        ),
        bottomNavigationBar: Obx(() => Container(
          color: Colors.black12,
          height: 145,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        width: 55,
                        height: 35,
                        child: MaterialButton(
                          elevation: 0,
                          onPressed: controller.startPrice.value == controller.startPriceOrg.value ? null : (){
                            controller.startPrice -= controller.increaseDecreasePrice;
                          },
                          color: Colors.black,
                          shape: const RoundedRectangleBorder(
                              side: BorderSide(color: Colors.black12),
                              borderRadius: BorderRadius.all(Radius.circular(10.0))
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 0),
                            child: Text('- ${controller.increaseDecreasePrice}', style: TextStyle(color: controller.startPrice.value == controller.startPriceOrg.value ? Colors.black26 : Colors.white, fontSize: 12.0, fontWeight: FontWeight.bold),),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text('₺${controller.startPrice}', style: const TextStyle(color: Colors.black87, fontSize: 20.0, fontWeight: FontWeight.bold)),
                  Column(
                    children: [
                      SizedBox(
                        width: 55,
                        height: 35,
                        child: MaterialButton(
                          elevation: 0,
                          onPressed: (){
                            controller.startPrice += controller.increaseDecreasePrice;
                          },
                          color: Colors.black,
                          shape: const RoundedRectangleBorder(
                              side: BorderSide(color: Colors.black12),
                              borderRadius: BorderRadius.all(Radius.circular(10.0))
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 0),
                            child: Text('+ ${controller.increaseDecreasePrice}', style: const TextStyle(color: Colors.white, fontSize: 12.0, fontWeight: FontWeight.bold),),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  SizedBox(
                    width: Get.width - 20,
                    height: 50,
                    child: MaterialButton(
                      elevation: 0,
                      onPressed: controller.incomingNewOffers.isNotEmpty ? null : controller.currentPrice == controller.startPrice ? null : ()async{
                        controller.incomingNewOffers.isEmpty ? null : await FlutterRingtonePlayer.play(fromAsset: "assets/delete.mp3", looping: false, asAlarm: false,volume: 10);
                        controller.sendOffer();
                      },
                      color: Colors.black,
                      shape: const RoundedRectangleBorder(
                          side: BorderSide(color: Colors.black12),
                          borderRadius: BorderRadius.all(Radius.circular(10.0))
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: Text('Send Offer With New Price', style: TextStyle(color: controller.incomingNewOffers.isNotEmpty ? Colors.black26 : controller.currentPrice == controller.startPrice ? Colors.black26 : Colors.white, fontSize: 12.0, fontWeight: FontWeight.bold),),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ],
          ),
        )),
        body: Obx(() => Column(
          children: [
            Container(
              color: Colors.black12,
              height: 20,
              width: Get.width,
              child: Center(child: Text('${controller.homeRomsText[controller.selectedHomeRoomIndex.value]}  |  ${controller.cleanTimeText[controller.selectedLessonIndex.value]}  |  ${controller.selectedDay}  |  ${controller.t2}', style: const TextStyle(color: Colors.black87, fontSize: 12.0, fontWeight: FontWeight.bold,fontStyle: FontStyle.italic))),
            ),
            controller.incomingNewOffers.isEmpty ? Expanded(
              child: SizedBox(
                height: Get.height,
                width: Get.width,
                child: Center(
                  child: Lottie.asset('assets/icons/request.json',height: 150),
                ),
              ),
            )
                :
            Expanded(
              child: ListView(
                shrinkWrap: true,
                  children: List.generate(controller.incomingNewOffers.length, (index) => Dismissible(
                    direction: DismissDirection.none,
                    key: Key(controller.incomingNewOffers.keys.elementAt(index).toString()),
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TimerWidget(index: controller.incomingNewOffers.keys.elementAt(index),newData: controller.incomingNewOffers[controller.incomingNewOffers.keys.elementAt(index)])
                    ),
                  ))
              ),
            )
          ],
        )),
      ),
    );
  }
}