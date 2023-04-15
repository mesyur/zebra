import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/OfferController.dart';

class SelectDayWidget extends GetView<OfferController>{
  const SelectDayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
      height: 75,
      color: Colors.transparent,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(7, (index) => GestureDetector(
          onTap: (){
            if(index != controller.currentDateSelectedIndex.value){
              controller.currentDateSelectedIndex.value = index;
              controller.currentDar.value = DateTime.now().add(Duration(days: index)).day;
              controller.selectedDay = '${DateTime.now().add(Duration(days: index)).day}/${DateTime.now().add(Duration(days: index)).month}'.toString();
              controller.onChangeDay();
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(controller.listOfDays[DateTime.now().add(Duration(days: index)).weekday - 1].toString(), style: const TextStyle(fontSize: 12, color: Colors.black)),
              Row(
                children: [
                  Text(DateTime.now().add(Duration(days: index)).day.toString(),style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Colors.black)),
                  const Text('/',style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Colors.black)),
                  Text(DateTime.now().add(Duration(days: index)).month.toString(),style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Colors.black)),
                ],
              ),
              Container(
                height: 30,
                width: Get.width * 0.12,
                decoration: BoxDecoration(
                    color: controller.currentDateSelectedIndex.value == index ? Colors.black : Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                    )
                ),
                child: const Center(child: Icon(Icons.check,color: Colors.white,)),
              )
            ],
          ),
        ),
        ),
      ),
    ));
  }

}