import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/HelpModel.dart';

class HelpController extends GetxController{
  List<HelpModel> titleList = [
    HelpModel(titleIcon: const Icon(Icons.contact_support_outlined),titleString: "Sıkça Sorulan Sorular"),
    HelpModel(titleIcon: const Icon(Icons.live_help_outlined),titleString: "Yasal Bilgiler"),
    HelpModel(titleIcon: const Icon(Icons.contactless_outlined),titleString: "Bize Ulaş"),
  ];
}


