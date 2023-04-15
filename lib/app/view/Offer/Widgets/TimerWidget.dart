import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:widget_circular_animator/widget_circular_animator.dart';
import 'dart:math' as math;

import '../../../controller/OfferController.dart';


class TimerWidget extends StatefulWidget {
  const TimerWidget({Key? key}) : super(key: key);

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> with SingleTickerProviderStateMixin{

  OfferController offerController = Get.find();
  late AnimationController animationController;
  String get timerString {
    Duration duration = animationController.duration! * animationController.value;
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    );
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      height: 170,
      child: Stack(
        children: [
          Container(
            height: 140,
            width: Get.width,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black26),
              borderRadius: BorderRadius.circular(6),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: const [
                        Text("data"),

                      ],
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: (){
                    animationController.stop();
                    animationController.reset();
                    animationController.reverse(from: animationController.value == 0.0 ? 1.0 : animationController.value);
                  },
                  child: Container(
                    width: 40,
                    height: 138,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(0.0),
                        bottomRight: Radius.circular(5.0),
                        topLeft: Radius.circular(0.0),
                        topRight: Radius.circular(5.0),
                      ),
                      color: Colors.lightGreen,
                    ),
                    child: const RotatedBox(
                        quarterTurns: 3,
                        child: Center(child: Text('+ kabul et', style: TextStyle(color: Colors.black87, fontSize: 20.0, fontWeight: FontWeight.bold)))),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 2,
            right: 50,
            child: Stack(
              alignment: Alignment.center,
              children: [
                WidgetCircularAnimator(
                  outerColor: Colors.black,
                  size: 60,
                  innerIconsSize: 1,
                  innerColor: Colors.transparent,
                  innerAnimation: Curves.linear,
                  child: Container(),
                ),
                Container(
                    height: 50,
                    width: 50,
                    margin: const EdgeInsets.only(left: 0, right: 0,top: 0),
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Positioned.fill(
                          child: AnimatedBuilder(
                            animation: animationController,
                            builder: ( context,  child) {
                              return CustomPaint(
                                  painter: TimerPainter(
                                    animation: animationController,
                                    backgroundColor: Colors.grey,
                                    color: Colors.red,
                                  )
                              );
                            },
                          ),
                        ),

                        Align(
                          alignment: FractionalOffset.center,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              const Icon(Icons.lens,size: 50,color: Colors.white,),
                              AnimatedBuilder(
                                  animation: animationController,
                                  builder: ( context,  child) {
                                    return Text(timerString,style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.red));
                                  }
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                ),
              ],
            ),)
        ],
      ),
    );
  }
}



class TimerPainter extends CustomPainter {
  TimerPainter({
    this.animation,
    this.backgroundColor,
    this.color,
  }) : super(repaint: animation);

  final Animation<double>? animation;
  final Color? backgroundColor, color;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor!
      ..strokeWidth = 5.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2.0, paint);
    paint.color = color!;
    double progress = (1.0 - animation!.value) * 2 * math.pi;
    canvas.drawArc(Offset.zero & size, math.pi * 1.5, -progress, false, paint);
  }

  @override
  bool shouldRepaint(TimerPainter oldDelegate) {
    return animation!.value != oldDelegate.animation!.value ||
        color != oldDelegate.color ||
        backgroundColor != oldDelegate.backgroundColor;
  }
}