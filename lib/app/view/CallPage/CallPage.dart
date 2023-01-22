import 'package:avatar_glow/avatar_glow.dart';
import 'package:custom_timer/custom_timer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../help/hive/localStorage.dart';
import '../../controller/CallController.dart';
import '../../../help/globals.dart' as globals;


class CallPage extends GetView<CallController>{
  const CallPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/images/img.png'),fit: BoxFit.cover)
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            child: ShaderMask(
                shaderCallback: (rect) {
                  return const LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Colors.white, Colors.transparent],
                  ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
                },
                blendMode: BlendMode.dstIn,
                child: Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                )
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: Obx(() => Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [



                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text("ÖZEL DERS",textAlign: TextAlign.center,style: TextStyle(color: Colors.black, fontSize: 17.0, fontWeight: FontWeight.w500)),
                            Text("1.17 Km Uzağında",textAlign: TextAlign.center,style: TextStyle(color: Colors.orangeAccent, fontSize: 12.0, fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text("Lab Lab Lab Lab Lab Lab Lab Lab Lab Lab Lab Lab Lab Lab Lab Lab Lab Lab Lab Lab Lab Lab Lab Lab Lab Lab Lab Lab Lab Lab Lab Lab Lab Lab Lab Lab Lab Lab Lab Lab Lab Lab Lab Lab Lab Lab ",textAlign: TextAlign.left,style: TextStyle(color: Colors.black, fontSize: 12.0, fontWeight: FontWeight.w500)),
                      ),


                      /// Profile Image
                      const SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.all(1),
                                width: 170,
                                height: 170,
                                child: AvatarGlow(
                                  glowColor: Colors.black12,
                                  endRadius: 190,
                                  duration: const Duration(milliseconds: 750),
                                  repeat: true,
                                  showTwoGlows: true,
                                  repeatPauseDuration: const Duration(milliseconds: 50),
                                  child: Material(
                                    elevation: 8.0,
                                    shape: const CircleBorder(),
                                    child: Container(
                                      width: 160,
                                      height: 160,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        image: DecorationImage(
                                          image: NetworkImage(globals.profilePhoto),
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius: const BorderRadius.all(Radius.circular(100.0)),
                                        border: Border.all(
                                          color: const Color(0xff000000),
                                          //width: 80,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      /// Name
                      const SizedBox(height: 10),
                      Text("${LocalStorage().getValue("firstName")} ${LocalStorage().getValue("lastName")}",textAlign: TextAlign.center,style: const TextStyle(color: Colors.black, fontSize: 17.0, fontWeight: FontWeight.w500)),

                      /// Timer
                      const SizedBox(height: 0),
                      controller.callAccepted.value ? CustomTimer(
                        begin: const Duration(seconds: 0),
                        end: const Duration(hours: 200),
                        controller: controller.timerController,
                        builder: (time) {
                          return SizedBox(
                            width: Get.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("${time.minutes}:${time.seconds}", style: const TextStyle(fontSize: 15,color: Colors.black87)),
                              ],
                            ),
                          );
                        },
                      ) : Container(),

                    ],
                  ),









                  /// Call Controllers
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        controller.imCaller.value && !controller.callAccepted.value ?
                        Center(
                          child: GestureDetector(
                            onTap: (){
                              // globals.socket.emit("cancel",[{
                              //   "id" : widget.otherProfileData["id"],
                              // }]);
                              Get.back();
                            },
                            child: const SizedBox(
                              child: CircleAvatar(
                                radius: 25.0,
                                backgroundColor: Colors.redAccent,
                                child: Icon(Icons.call_end,color: Colors.white,),
                              ),
                            ),
                          ),
                        )
                            :
                        controller.callAccepted.value ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                                onTap: () async {
                                  controller.toggleAudio();
                                },
                                child:  SizedBox(
                                    child: CircleAvatar(
                                        radius: 25.0,
                                        backgroundColor: Colors.white.withOpacity(0.9),
                                        child: Icon( controller.isFirstAudio.value ? Icons.mic : Icons.mic_off,color: Colors.black87)))
                            ),
                            GestureDetector(
                                onTap: () async {
                                  controller.soundOutPut();
                                },
                                child:  SizedBox(
                                    child: CircleAvatar(
                                        radius: 25.0,
                                        backgroundColor: Colors.white.withOpacity(0.9),
                                        child: Icon(controller.speaker.value ? Icons.voice_over_off : Icons.record_voice_over_outlined,color: Colors.black87)))
                            ),
                            GestureDetector(
                              onTap: (){
                                // globals.socket.emit("cancel",[{
                                //   "id" : widget.otherProfileData["id"],
                                // }]);
                                Get.back();
                              },
                              child: const SizedBox(
                                child: CircleAvatar(
                                  radius: 25.0,
                                  backgroundColor: Colors.redAccent,
                                  child: Icon(Icons.call_end,color: Colors.white,),
                                ),
                              ),
                            ),
                          ],
                        )
                            :
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: (){
                                controller.callAccepted.value = true;
                                // globals.socket.emit("ansser",[{
                                //   "id" : widget.otherProfileData["id"],
                                // }]);
                                controller.init();
                              },
                              child: const SizedBox(
                                child: CircleAvatar(
                                  radius: 25.0,
                                  backgroundColor: Colors.green,
                                  child: Icon(Icons.call,color: Colors.white,),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                // globals.socket.emit("cancel",[{
                                //   "id" : widget.otherProfileData["id"],
                                // }]);
                              },
                              child: const SizedBox(
                                child: CircleAvatar(
                                  radius: 25.0,
                                  backgroundColor: Colors.redAccent,
                                  child: Icon(Icons.call_end,color: Colors.white,),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )

                ],
              ),
            )),
          ),
        ],
      ),
    );
  }
}