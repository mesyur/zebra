import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/CallController.dart';

class Call extends GetView<CallController>{
  const Call({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.redAccent,
    );
  }
}