import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/ProfileController.dart';
import '../../../model/countryCodes.dart';


class IsoProfileEdit extends GetView<ProfileController> {
  const IsoProfileEdit({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Container(
          //   width: double.infinity,
          //   height: double.infinity,
          //   decoration: BoxDecoration(
          //       gradient: LinearGradient(
          //           begin: FractionalOffset.topCenter,
          //           end: FractionalOffset.bottomCenter,
          //           colors: [
          //             controller.accentColor.withOpacity(0.5),
          //             controller.accentColor
          //           ],
          //           stops: const [
          //             0.0,
          //             1.0
          //           ]
          //       )
          //   ),
          // ),
          Column(
            children: [
              const SizedBox(height: 30),
              /// APP BAR
              SizedBox(
                height: 65,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: ()=> Navigator.of(context).pop(),
                      child: const Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Icon(Icons.arrow_back_ios,color: Colors.black54,),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: TextField(
                          cursorColor: const Color(0xffC00D1E),
                          style: const TextStyle(color: Colors.black54),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'search'.tr,
                              hintStyle: const TextStyle(color: Colors.black54),
                              contentPadding: const EdgeInsets.only(left: 10)
                          ),
                          onChanged: (v){
                            controller.buildSearchList(v);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              /// LIST OF COUNTRY
              Expanded(
                child: Obx(() => ListView(
                  shrinkWrap: true,
                  children: List.generate(controller.codeList.length, (index) => Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: ()async{
                                controller.codeMyIso.value = controller.codeList[index]["code"]!; // IQ
                                controller.dialCodeMyIso.value = controller.codeList[index]["dial_code"]!; // +964
                                controller.flagMyIso.value = 'assets/flags/${controller.codeList[index]['code']?.toLowerCase()}.png';
                                controller.codeList.value = codes;
                                Navigator.of(context).pop();
                              },
                              child: ListTile(
                                leading: Image(image: AssetImage('assets/flags/${controller.codeList[index]['code']?.toLowerCase()}.png'), height: 20,),
                                dense: true,
                                title: Text('${controller.codeList[index]['name']}',style: const TextStyle(color: Colors.black54),),
                                trailing: Text('${controller.codeList[index]['dial_code']}',style: const TextStyle(color: Colors.black54))
                              ),
                            ),
                            const Divider()
                          ],
                        ),
                      ),
                    ],
                  )),
                )),
              )
            ],
          ),
        ],
      ),
    );
  }
}
