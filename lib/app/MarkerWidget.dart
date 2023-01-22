import 'dart:math';
import 'package:flutter/material.dart';



class MarkerWidget extends StatelessWidget {
  List dataImage = [];

  MarkerWidget({super.key,required this.dataImage});


  //final List<int> data = [1,2,3,4,5,6];
  final double radius =  25;
  final double angleDiff = (pi + pi) / 6;
  late double currentAngle = pi;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      height: 65,
      width: 65,
      alignment: Alignment.center,
      child: Stack(
          children: List.generate(dataImage.length, (index){
            currentAngle += angleDiff;
            final x = cos(currentAngle)  * radius;
            final y = sin(currentAngle) * radius;
            return Transform(
                transform:
                //index == 0 ? Matrix4.translationValues(0.0, 0.0 , 0.0) :
                Matrix4.translationValues(x, y , 0.0),
                child: Image.asset(dataImage[index] == 'assets/categoryIcons/null.png' ? "assets/categoryIcons/yol-yardim.png" : dataImage[index],height: 20,)
            );
          })
      ),
    );
  }
}