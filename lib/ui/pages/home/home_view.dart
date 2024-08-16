import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'home_view_controller.dart';
import 'widgets/map_view.dart';

class HomeView extends GetView<HomeViewController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body: const SafeArea(
        child: MapView(),
      ),
    );
  }
}
