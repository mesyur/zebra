import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../help/hive/localStorage.dart';

class LoginMiddleware extends GetMiddleware{


  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {

    if(LocalStorage().getValue("intro") != null){
      if(LocalStorage().getValue("login")){
        return const RouteSettings(name: '/MainPage');
      }
      return null;
    }else{
      return const RouteSettings(name: '/Intro');
    }
  }
}