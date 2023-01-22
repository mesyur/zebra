import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/HelpController.dart';


class Help extends GetView<HelpController>{
  const Help({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Help", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
        centerTitle: true,
      ),
      body: Column(
        children: List.generate(controller.titleList.length, (index) => GestureDetector(
          onTap: (){
           index == 0 ? Get.toNamed('/Sss') : index == 1 ? Get.toNamed('/LegalInformation') : index == 2 ? Get.toNamed('/ContactUs') : null;
          },
          child: Container(
            color: Colors.white.withOpacity(0.1),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(12.0),
                                bottomRight: Radius.circular(12.0),
                                topLeft: Radius.circular(12.0),
                                topRight: Radius.circular(12.0),
                              ),
                              color: Colors.transparent,
                              // boxShadow: [
                              //   BoxShadow(
                              //     color: const Color(0xff512E70).withOpacity(0.15),
                              //     offset: const Offset(0.0, 0.5), //(x,y)
                              //     blurRadius: 5,
                              //   ),
                              // ],
                            ),
                            child: controller.titleList[index].titleIcon,
                          ),
                          const SizedBox(width: 10),
                          Text(controller.titleList[index].titleString, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15)),
                        ],
                      ),
                      const Icon(Icons.arrow_forward_ios_sharp,size: 20,)
                    ],
                  ),
                ),
                const Divider()
              ],
            ),
          ),
        )),
      ),
    );
  }
}