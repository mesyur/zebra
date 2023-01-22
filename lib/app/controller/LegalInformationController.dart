import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/LegalInformationModel.dart';

class LegalInformationController extends GetxController{
  List<LegalInformationModel> titleList = [
    LegalInformationModel(titleIcon: const Icon(Icons.fact_check_outlined),titleString: "kullanım koşulları"),
    LegalInformationModel(titleIcon: const Icon(Icons.local_police_outlined),titleString: "Gazilik"),
    LegalInformationModel(titleIcon: const Icon(Icons.security),titleString: "Kişisel Verilerin Korunması"),
    LegalInformationModel(titleIcon: const Icon(Icons.lightbulb_outline_sharp),titleString: "Aydınlatma Metni"),
  ];
}