import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:zebra/app/view/Intro/widgets/ColorsSys.dart';
import '../../../help/hive/localStorage.dart';
import '../../controller/IntroController.dart';

class Intro extends GetView<IntroController>{
  const Intro({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[



          PageView(
            physics: const PageScrollPhysics(),
            onPageChanged: (int page) {
              controller.currentIndex.value = page;
            },
            controller: controller.pageController,
            children: List.generate(controller.imageList.length, (index) => Image.asset(controller.imageList[index],fit: BoxFit.fill,),),
          ),



          Positioned(
            bottom: 50,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 60),
                  child: Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _buildIndicator(),
                  )),
                ),


                Obx(() => controller.currentIndex.value > 0 ?
                Row(
                  children: [
                    GestureDetector(
                      onTap: (){
                        controller.pageController.jumpToPage(controller.currentIndex.value - 1);
                      },
                      child: Container(
                        height: 50,
                        width: Get.width * .15,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.white,width: 2),
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(7),
                            bottomRight: Radius.circular(7),
                            topLeft: Radius.circular(7),
                            topRight: Radius.circular(7),
                          ),
                        ),
                        child: const Center(
                          child: Icon(Icons.arrow_back,color: Colors.black,size: 30),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    GestureDetector(
                      onTap: controller.currentIndex.value == 2 ? null : (){
                        controller.pageController.jumpToPage(controller.currentIndex.value + 1);
                      },
                      child: Container(
                        height: 50,
                        width: Get.width * .65,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(color: controller.currentIndex.value == 2 ? Colors.grey : Colors.white,width: 2),
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(7),
                            bottomRight: Radius.circular(7),
                            topLeft: Radius.circular(7),
                            topRight: Radius.circular(7),
                          ),
                        ),
                        child: const Center(
                          child: Text('Sonraki',style: TextStyle(color: Colors.white,fontSize: 17)),
                        ),
                      ),
                    ),
                  ],
                )
                    :
                GestureDetector(
                  onTap: controller.currentIndex.value == 2 ? null : (){
                    controller.pageController.jumpToPage(controller.currentIndex.value + 1);
                  },
                  child: Container(
                    height: 50,
                    width: Get.width * .8,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(color: Colors.white,width: 2),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(7),
                        bottomRight: Radius.circular(7),
                        topLeft: Radius.circular(7),
                        topRight: Radius.circular(7),
                      ),
                    ),
                    child: const Center(
                      child: Text('Sonraki',style: TextStyle(color: Colors.white,fontSize: 17)),
                    ),
                  ),
                ),)

              ],
            ),
          ),




          Positioned(
            top: 60,
            right: 40,
            child: GestureDetector(
              onTap: (){
                LocalStorage().setValue('intro', true);
                Get.toNamed('/Login');
              },
              child: Row(
                children: [
                  Text('Atla', style: TextStyle(
                      color: ColorSys.gray,
                      fontSize: 18,
                      fontWeight: FontWeight.w400
                  ),
                  ),
                  const SizedBox(width: 10),
                  Icon(Icons.arrow_forward_ios_outlined,color: ColorSys.gray,size: 17,)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }


  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 6,
      width: isActive ? 30 : 6,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
          color: ColorSys.secoundry,
          borderRadius: BorderRadius.circular(5)
      ),
    );
  }

  List<Widget> _buildIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i< controller.imageList.length; i++) {
      if (controller.currentIndex.value == i) {
        indicators.add(_indicator(true));
      } else {
        indicators.add(_indicator(false));
      }
    }
    return indicators;
  }
}