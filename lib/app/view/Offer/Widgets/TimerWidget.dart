import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:get/get.dart';
import 'package:widget_circular_animator/widget_circular_animator.dart';
import 'dart:math' as math;

import '../../../controller/OfferController.dart';
import '../../../model/SocketModel.dart';


class TimerWidget extends StatefulWidget {
  final SocketModel? newData;
  final int? index;
  const TimerWidget({Key? key,this.newData,this.index}) : super(key: key);

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
    animationController.stop();
    animationController.reset();
    animationController.reverse(from: animationController.value == 0.0 ? 1.0 : animationController.value);
    animationController.addListener(()async{
      if(animationController.isDismissed && animationController.value == 0.0){
        offerController.initialController.socket.emit("offerCanceled",[{
          'id': widget.newData!.data.userData.id
        }]);
        await FlutterRingtonePlayer.play(fromAsset: "assets/delete.mp3", looping: false, asAlarm: false,volume: 10);
        offerController.incomingNewOffers.remove(widget.index!);
      }
    });
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
      height: 154,
      child: Stack(
        children: [
          Container(
            height: 125,
            width: Get.width,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black26),
              borderRadius: BorderRadius.circular(6),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${widget.newData!.data.userData.firstName} ${widget.newData!.data.userData.lastName}', style: const TextStyle(color: Colors.black87, fontSize: 15.0, fontWeight: FontWeight.bold,fontStyle: FontStyle.italic)),
                      Text('Price : ₺${widget.newData!.data.price}', style: const TextStyle(color: Colors.redAccent, fontSize: 15.0, fontWeight: FontWeight.bold,fontStyle: FontStyle.normal)),
                      const Divider(),
                      Text('Day : ${widget.newData!.data.selectedDay}           Time : ${widget.newData!.data.t2}', style: const TextStyle(color: Colors.black87, fontSize: 12.0, fontWeight: FontWeight.bold,fontStyle: FontStyle.normal)),
                      Text('Rooms : ${widget.newData!.data.homeRomsText}        Hours : ${widget.newData!.data.cleanTimeText}', style: const TextStyle(color: Colors.black87, fontSize: 12.0, fontWeight: FontWeight.bold,fontStyle: FontStyle.normal)),

                    ],
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    animationController.stop();
                    // animationController.reset();
                    // animationController.reverse(from: animationController.value == 0.0 ? 1.0 : animationController.value);
                    offerController.incomingNewOffers.clear();
                    Get.back();
                    offerController.initialController.socket.emit('openConversion',[{
                      'zebraUserData': offerController.initialController.userData,
                      'zebraProviderUserId': widget.newData!.data.userData.id,
                      'zebraProviderUserFirstName': widget.newData!.data.userData.firstName,
                      'zebraProviderUserListName': widget.newData!.data.userData.lastName,
                      'price': widget.newData!.data.price,
                      'selectedDay': widget.newData!.data.selectedDay,
                      't2': widget.newData!.data.t2,
                      'homeRomsText': widget.newData!.data.homeRomsText,
                      'cleanTimeText': widget.newData!.data.cleanTimeText,
                      'noteController': offerController.noteController.text,
                    }]);
                  },
                  child: Container(
                    width: 40,
                    height: 133,
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
                        child: Center(child: Text('+ kabul et', style: TextStyle(color: Colors.black87, fontSize: 18.0, fontWeight: FontWeight.bold)))),
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