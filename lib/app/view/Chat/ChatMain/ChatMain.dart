import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../help/GetStorage.dart';
import '../../../controller/ChatMainController.dart';
import '../../../model/Global.dart';



class ChatMain extends GetView<ChatMainController>{
  const ChatMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
        centerTitle: true,
      ),
      body: Obx(() => controller.chatListModel.value == null ? Container() : controller.obx((state) => Column(
        children: List.generate(controller.chatListModel.value!.data.length, (index) => GestureDetector(
          onTap: ()async{
            await box.read('userIds').remove(controller.chatListModel.value!.data[index].author.id);
            controller.change(null,status: RxStatus.success());
            Get.toNamed('/ChatPage',arguments: [controller.chatListModel.value!.data[index].author.id,controller.chatListModel.value!.data[index].chatId]);
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
                            child: const Icon(Icons.chat_bubble_outline),
                          ),
                          const SizedBox(width: 10),
                          Text('${controller.chatListModel.value!.data[index].author.firstName} ${controller.chatListModel.value!.data[index].author.lastName}', style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15)),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.arrow_forward_ios_sharp,size: 20),
                          box.read('userIds') == null ? const Icon(Icons.lens,size: 5,color: Colors.transparent) : Icon(Icons.lens,size: 5,color: box.read('userIds').contains(controller.chatListModel.value!.data[index].author.id) ? Colors.red : Colors.transparent),
                        ],
                      ),
                    ],
                  ),
                ),
                const Divider()
              ],
            ),
          ),
        )),
      ))),
    );
  }
}