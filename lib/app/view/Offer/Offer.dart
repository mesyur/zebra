import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:widget_circular_animator/widget_circular_animator.dart';
import '../../controller/OfferController.dart';
import 'Widgets/SelectDayWidget.dart';
import 'Widgets/TimerWidget.dart';
import 'Widgets/src/date_time_picker_type.dart';
import 'Widgets/src/date_time_picker_view.dart';



class Offer extends GetView<OfferController>{
  const Offer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Offers", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
        centerTitle: true,
        surfaceTintColor: Colors.white,
      ),
      body: Obx(() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          children: [




        //    const TimerWidget(),






            /// Top Text
            const SizedBox(height: 10),
            const Text('Mükemmel bir hizmet almak için lütfen aşağıdaki bilgileri seçin.', style: TextStyle(color: Colors.black87, fontSize: 20.0, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),
            const Divider(color: Colors.black26,),
            const SizedBox(height: 15),
            // Expanded(child: ListView(
            //   children: List.generate(controller.incomingNewOffers.length, (index) => const Card()),
            // )),
            Container(
             // height: 220,
              width: Get.width,
              color: Colors.transparent,
              child: Column(
                children: [


                  /// Home Rooms
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(controller.homeRomsText.length, (index) => GestureDetector(
                      onTap: (){
                        controller.selectedHomeRoomIndex.value = index;
                      },
                      child: Container(
                        width: 55,
                        height: 25,
                        decoration: BoxDecoration(
                            color: controller.selectedHomeRoomIndex.value == index ? Colors.black54 : Colors.white,
                            border: Border.all(color: Colors.grey),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5),
                              bottomLeft: Radius.circular(5),
                              bottomRight: Radius.circular(5),
                            )
                        ),
                        child: Center(child: Text(controller.homeRomsText[index],style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: controller.selectedHomeRoomIndex.value == index ? Colors.white : Colors.black38,))),
                      ),
                    )),
                  ),


                  /// Time
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(controller.cleanTimeText.length, (index) => GestureDetector(
                      onTap: (){
                        controller.selectedLessonIndex.value = index;
                      },
                      child: Container(
                        width: 55,
                        height: 25,
                        decoration: BoxDecoration(
                            color: controller.selectedLessonIndex.value == index ? Colors.black54 : Colors.white,
                            border: Border.all(color: Colors.grey),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5),
                              bottomLeft: Radius.circular(5),
                              bottomRight: Radius.circular(5),
                            )
                        ),
                        child: Center(child: Text(controller.cleanTimeText[index],style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: controller.selectedLessonIndex.value == index ? Colors.white : Colors.black38,))),
                      ),
                    )),
                  ),


                  /// Date Select
                  const SizedBox(height: 20),
                  const SelectDayWidget(),



                  /// Time
                  const SizedBox(height: 10),
                    controller.changer.value == 1 ? Container(height: 45) : DateTimePicker(
                    type: DateTimePickerType.Time,
                    timeInterval: const Duration(hours: 1),
                    is24h: true,
                    startTime: DateTime.now().day == controller.currentDar.value ? DateTime.now() : null,
                    onTimeChanged: (time) {
                      controller.t2.value = DateFormat('hh:mm:ss aa').format(time);
                    },
                  ),



                  /// NOt
                  const SizedBox(height: 10),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        child: Container(
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
                          height: 130,
                          child: TextFormField(
                            maxLines: 4,
                            controller: controller.noteController,
                            textAlignVertical: TextAlignVertical.center,
                            keyboardType: TextInputType.text,
                            cursorColor: const Color(0xFF26242e),
                            style: const TextStyle(fontWeight: FontWeight.normal,fontSize: 15,letterSpacing: 0,color: Color(0xff363636)),
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
                                hintText: 'SBize kullanıcı\ngeri bildiriminizi bırakın',
                                fillColor: const Color(0xffffffff),
                                filled: true
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),


                  const SizedBox(height: 10),
                  const Divider(color: Colors.black26,),

                  /// Price AND BTN
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
                        width: Get.width - 0,
                        height: 50,
                        child: MaterialButton(
                          elevation: 0,
                          onPressed: controller.currentPrice == controller.startPrice ? null : (){
                            controller.sendOffer();
                          },
                          color: Colors.black,
                          shape: const RoundedRectangleBorder(
                              side: BorderSide(color: Colors.black12),
                              borderRadius: BorderRadius.all(Radius.circular(10.0))
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 0),
                            child: Text('Send Offer With New Price', style: TextStyle(color: controller.currentPrice == controller.startPrice ? Colors.black26 : Colors.white, fontSize: 12.0, fontWeight: FontWeight.bold),),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }

}




