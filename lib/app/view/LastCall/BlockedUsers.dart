import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/LastCallController.dart';

class BlockedUsers extends GetView<LastCallController>{
  const BlockedUsers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Blocked Users".tr, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
        centerTitle: true,
      ),
      body: Obx(() => controller.blockedUserList.isEmpty ? const Center(child: Text('No Blocked User!')) : ListView(
        children: List.generate(controller.blockedUserList.length, (index) => Column(
          children: [
            ListTile(
              title: Text('${controller.blockedUserList[index].firstName} ${controller.blockedUserList[index].lastName}'),
              trailing: Column(
                children: [
                  SizedBox(
                    width: 80,
                    height: 35,
                    child: MaterialButton(
                      elevation: 0,
                      onPressed: (){
                        controller.unBlockedUsers(controller.blockedUserList[index].blockedUserId);
                      },
                      color: Colors.lightGreen,
                      shape: const RoundedRectangleBorder(
                          side: BorderSide(color: Colors.black12),
                          borderRadius: BorderRadius.all(Radius.circular(10.0))
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: Text('Un Block'.tr, style: const TextStyle(color: Colors.black87, fontSize: 10.0, fontWeight: FontWeight.bold),),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            controller.blockedUserList.length == index + 1 ? Container() : const Divider()
          ],
        ),),
      ),)
    );
  }

}