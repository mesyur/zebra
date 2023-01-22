import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MapPickerController {
  late Function mapMoving;
  late Function mapFinishedMoving;
}

class MapPicker extends StatefulWidget {
  final Widget child;
  final Widget iconWidget;
  final bool showDot;
  final MapPickerController mapPickerController;

  const MapPicker(
      {super.key, required this.mapPickerController,
        required this.iconWidget,
        this.showDot = true,
        required this.child});

  @override
  _MapPickerState createState() => _MapPickerState();
}

class _MapPickerState extends State<MapPicker>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 100));
    if (widget.mapPickerController != null) {
      widget.mapPickerController.mapMoving = mapMoving;
      widget.mapPickerController.mapFinishedMoving = mapFinishedMoving;
    }
  }

  void mapMoving() {
    if (!animationController.isCompleted || !animationController.isAnimating) {
      animationController.forward();
    }
  }

  void mapFinishedMoving() {
    animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        Container(),
        AnimatedBuilder(
            animation: animationController,
            builder: (context, snapshot) {
              return Padding(
                padding: EdgeInsets.only(bottom: Get.height / 2 - 100,),
                child: Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Transform.translate(
                        offset: Offset(0, -10 * animationController.value),
                        child: widget.iconWidget,
                      ),
                      if(widget.showDot)
                        Container(
                          width: 5,
                          height: 5,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(5)),
                        )
                    ],
                  ),
                ),
              );
            }),
      ],
    );
  }
}