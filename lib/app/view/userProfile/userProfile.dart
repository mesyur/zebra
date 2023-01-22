import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/UserProfileController.dart';

class UserProfile extends GetView<UserProfileController>{
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
        centerTitle: true,
      ),

    );
  }
}
