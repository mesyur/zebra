import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:rating_dialog/rating_dialog.dart';
import '../../controller/LastCallController.dart';

class LastCall extends GetView<LastCallController>{
  const LastCall({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Last Call".tr, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: (){
              controller.blockedUser();
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.verified_user_outlined),
                Text('Blocked'.tr,style: const TextStyle(fontSize: 10),)
              ],
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: (){
              controller.favoriteUser();
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.favorite_border_outlined),
                Text('Favorite'.tr,style: const TextStyle(fontSize: 10),)
              ],
            ),
          ),
          const SizedBox(width: 5),
        ],
        surfaceTintColor: Colors.white,
      ),
      body: controller.obx((state) => ListView(
        children: List.generate(state!.data.length, (index) => Column(
          children: [
            Container (
              decoration: BoxDecoration (
                  color: state.data[index].isBlocked == 0 ? Colors.transparent : Colors.red.withOpacity(0.1)
              ),
              child: ListTile(
                title: Text('${state.data[index].firstName} ${state.data[index].lastName} / ${state.data[index].name}'),
                subtitle: Row(
                  children: [
                    Text('${controller.getDateTime(datetime: state.data[index].createdDate)}\n${state.data[index].isAnswered == 1 ? 'Answered'.tr : 'Not Answered'.tr}'),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Icon(state.data[index].callType == 'out' ? Icons.call_made : Icons.call_received,color: state.data[index].callType == 'out' ? Colors.black38 : Colors.black,size: 15,),
                    ),
                  ],
                ),
                leading: GestureDetector(
                  onTap: (){},
                  child: const Image(image: AssetImage("assets/icons/call.png"),height: 35,),
                ),
                trailing: PopupMenuButton<int>(
                    elevation: 4,
                    itemBuilder: (BuildContext context) => <PopupMenuItem<int>>[
                      PopupMenuItem<int>(value: 1, child: Text(state.data[index].isBlocked == 0 ? 'Engelle' : 'Engeli Kaldır')),
                      PopupMenuItem<int>(value: 2, child: Text(state.data[index].isFavorited == 0 ? 'fav' : 'un fav')),
                      const PopupMenuItem<int>(value: 3, child: Text('Puanla')),
                      const PopupMenuItem<int>(value: 4, child: Text('Report')),
                    ],
                    onSelected: (int value) {
                      if(value == 1){
                        QuickAlert.show(
                            context: context,
                            type: QuickAlertType.warning,
                            text: state.data[index].isBlocked == 0 ?  'Bu kullanıcıyı gerçekten engellemek istiyor musunuz ?'.tr : 'Kullanıcı engelini kaldırmak istiyor musunuz ?'.tr,
                            confirmBtnText: 'Yes'.tr,
                            cancelBtnText: 'No'.tr,
                            confirmBtnColor: Colors.redAccent,
                            showCancelBtn: true,
                            onConfirmBtnTap: (){
                              Get.back();
                              controller.blockUnBlockUser(state.data[index].userId);
                            }
                        );
                      }else if(value == 2){
                        QuickAlert.show(
                            context: context,
                            type: QuickAlertType.warning,
                            text: state.data[index].isFavorited == 0 ?  'Bu kullanıcıyı gerçekten fav istiyor musunuz ?'.tr : 'Kullanıcı fav kaldırmak istiyor musunuz ?'.tr,
                            confirmBtnText: 'Yes'.tr,
                            cancelBtnText: 'No'.tr,
                            confirmBtnColor: Colors.redAccent,
                            showCancelBtn: true,
                            onConfirmBtnTap: (){
                              Get.back();
                              controller.favoriteUnFavoriteUsers(state.data[index].callId);
                            }
                        );
                      }else if(value == 4){
                        Get.toNamed("/ReportUser",arguments: state.data[index].userId);
                      }else{
                        showDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (context) => RatingDialog(
                            initialRating: 1.0,
                            title: Text('${state.data[index].firstName} ${state.data[index].lastName}', textAlign: TextAlign.center, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),),
                            message: Text(state.data[index].name, textAlign: TextAlign.center, style: const TextStyle(fontSize: 15),),
                            image: const Image(image: AssetImage("assets/app/logo.png"),height: 35),
                            submitButtonText: 'Submit'.tr,
                            submitButtonTextStyle: const TextStyle(color: Colors.black54,fontSize: 20),
                            commentHint: 'Set your custom comment hint'.tr,
                            onSubmitted: (response) {
                              if(response.rating == 1.0){}else {
                                controller.rateUser(state.data[index].userId,response.rating,response.comment);
                              }
                            },
                          ),
                        );
                      }
                    }),
              ),
            ),
            state.data.length == index + 1 ? Container() : const Divider()
          ],
        ),),
      ),onLoading: Container()),
    );
  }

}