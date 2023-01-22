import 'package:flutter/material.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:get/get.dart';
import '../../../../controller/SssController.dart';

class Sss extends GetView<SssController>{
  const Sss({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sıkça Sorulan Sorular", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
        centerTitle: true,
      ),
      body: ExpandedTileList.builder(
        itemCount: controller.SssList.length,
        maxOpened: 1,
        reverse: false,
        itemBuilder: (context, index, expandedTileController) {
          return ExpandedTile(
            theme: const ExpandedTileThemeData(
              headerColor: Colors.white,
              headerRadius: 0.0,
              headerPadding: EdgeInsets.all(10.0),
              headerSplashColor: Colors.black12,
              contentBackgroundColor: Colors.white,
              contentPadding: EdgeInsets.all(0.0),
              contentRadius: 0.0,
            ),
            controller: expandedTileController,
            title: Text(controller.SssList[index].titleString, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15)),
            content: Container(
              color: Colors.white10.withOpacity(0.05),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(controller.SssList[index].subtitleString)),
              ),
            ),
          );
        },
      ),

    );
  }
}
