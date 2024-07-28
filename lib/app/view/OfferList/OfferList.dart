import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../../help/GetStorage.dart';
import '../../controller/OfferListController.dart';



class OfferList extends GetView<OfferListController>{
  const OfferList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Offers", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
        centerTitle: true,
        surfaceTintColor: Colors.white,
      ),
      body: Obx(() => controller.offerListModel.value == null ? Container() : controller.obx((state) => SingleChildScrollView(
        child: Column(
          children: List.generate(controller.offerListModel.value!.data.length, (index) => GestureDetector(
            onTap: ()async{},
            child: Container(
              width: Get.width,
              margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(12.0),
                  bottomRight: Radius.circular(12.0),
                  topLeft: Radius.circular(12.0),
                  topRight: Radius.circular(12.0),
                ),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xff512E70).withOpacity(0.3),
                    offset: const Offset(0.0, 0.5), //(x,y)
                    blurRadius: 5,
                  ),
                ],
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Center(child: Text('${controller.offerListModel.value!.data[index].firstName} ${controller.offerListModel.value!.data[index].lastName}',style: const TextStyle(color: Colors.black,fontSize: 17,fontWeight: FontWeight.bold))),
                      ),
                      SizedBox(
                        child: Lottie.asset('assets/icons/servicesX.json',height: 50),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Divider(),
                        Text('Price : ₺${1000000}',style: const TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold,fontFamily: 'Montserrat')),
                        const Divider(),
                        Text('detail : ${controller.offerListModel.value!.data[index].detail}',style: const TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold)),
                        const Divider(),
                        Text('Day : ${controller.offerListModel.value!.data[index].serviceDate}',style: const TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold)),
                        const Divider(),
                        Text('Time : ${controller.offerListModel.value!.data[index].serviceTime}',style: const TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold)),
                        const Divider(),
                        Text('Note : ${controller.offerListModel.value!.data[index].note}',style: const TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
        ),
      ))),
    );
  }
}