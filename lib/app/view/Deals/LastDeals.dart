import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rating_dialog/rating_dialog.dart';
import '../../controller/LastDealsController.dart';

class LastDeals extends GetView<LastDealsController>{
  const LastDeals({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Last Deals", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
        centerTitle: true,
        surfaceTintColor: Colors.white,
      ),
      body: controller.obx((state) => ListView(
        children: List.generate(state!.data.length, (index) => Column(
          children: [
            ListTile(
              title: Text('${state.data[index].firstName} ${state.data[index].lastName} / ${state.data[index].name}'),
              subtitle: Row(
                children: [
                  Text('${controller.getDateTime(datetime: state.data[index].createdDate)}'),
                ],
              ),
              leading: GestureDetector(
                onTap: (){},
                child: const Image(image: AssetImage("assets/icons/hs.png"),height: 35,),
              ),
              trailing: PopupMenuButton<int>(
                  elevation: 4,
                  itemBuilder: (BuildContext context) => <PopupMenuItem<int>>[
                    const PopupMenuItem<int>(value: 1, child: Text('Puanla')),
                    const PopupMenuItem<int>(value: 2, child: Text('Report')),
                  ],
                  onSelected: (int value) {
                    if(value == 2){
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
                          submitButtonText: 'Submit',
                          submitButtonTextStyle: const TextStyle(color: Colors.black54,fontSize: 20),
                          commentHint: 'Set your custom comment hint',
                          onSubmitted: (response) {
                            if(response.rating == 1.0){}else {
                              controller.rateUser(state.data[index].userId,response.rating,response.comment,controller.getDateTime(datetime: state.data[index].createdDate));
                            }
                          },
                        ),
                      );
                    }
                  }),
            ),
            state.data.length == index + 1 ? Container() : const Divider()
          ],
        ),),
      ),onLoading: Container()),
    );
  }

}