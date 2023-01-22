import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:zebra/app/view/Intro/widgets/ColorsSys.dart';
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
            onPageChanged: (int page) {
              controller.currentIndex.value = page;
            },
            controller: controller.pageController,
            children: List.generate(controller.imageList.length, (index) => Image.asset(controller.imageList[index],fit: BoxFit.fill,),),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 60),
            child: Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildIndicator(),
            )),
          ),
          Positioned(
            top: 30,
            right: 30,
            child: Obx(() => GestureDetector(
              onTap: (){
                Get.toNamed('/Login');
              },
              child: Text(controller.currentIndex.value == controller.imageList.length -1 ? 'HADİ BAŞLAYALIM' : 'Atla', style: TextStyle(
                  color: ColorSys.gray,
                  fontSize: 18,
                  fontWeight: FontWeight.w400
              ),
              ),
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