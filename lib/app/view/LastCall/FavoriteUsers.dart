import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/LastCallController.dart';

class FavoriteUsers extends GetView<LastCallController>{
  const FavoriteUsers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite Users", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
        centerTitle: true,
      ),
      body: Obx(() => controller.favoriteUserList.isEmpty ? const Center(child: Text('No Favorite User!')) : ListView(
        children: List.generate(controller.favoriteUserList.length, (index) => Column(
          children: [
            ListTile(
              title: Text('${controller.favoriteUserList[index].firstName} ${controller.favoriteUserList[index].lastName}'),
              trailing: Column(
                children: [
                  SizedBox(
                    width: 80,
                    height: 35,
                    child: MaterialButton(
                      elevation: 0,
                      onPressed: (){
                        controller.favoriteUnFavoriteUsers(controller.favoriteUserList[index].callId);
                      },
                      color: Colors.lightGreen,
                      shape: const RoundedRectangleBorder(
                          side: BorderSide(color: Colors.black12),
                          borderRadius: BorderRadius.all(Radius.circular(10.0))
                      ),
                      child: const Padding(
                        padding: EdgeInsets.only(top: 0),
                        child: Text('Un Favorite', style: TextStyle(color: Colors.black87, fontSize: 10.0, fontWeight: FontWeight.bold),),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            controller.favoriteUserList.length == index + 1 ? Container() : const Divider()
          ],
        ),),
      ),)
    );
  }

}