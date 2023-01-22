import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../help/loadingClass.dart';

class IntroController extends GetxController with StateMixin ,LoadingDialog{
  late PageController pageController;
  RxInt currentIndex = 0.obs;

  List imageList = [
    // 'assets/images/hizmetveren-1.jpg',
    // 'assets/images/hizmetveren-2.jpg',
    // 'assets/images/hizmetveren-3.jpg',
    'assets/images/kullanìcì-1.jpg',
    'assets/images/kullanìcì-2.jpg',
    'assets/images/kullanìcì-3.jpg'
  ];


  @override
  void onInit() {
    pageController = PageController(initialPage: 0,keepPage: true);
    super.onInit();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

}