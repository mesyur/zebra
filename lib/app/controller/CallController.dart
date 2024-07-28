import 'dart:async';
import 'dart:convert';
//import 'package:advanced_audio_manager/advanced_audio_manager.dart';
//import 'package:advanced_audio_manager/advanced_audio_manager.dart';
import 'package:custom_timer/custom_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropdown_alert/alert_controller.dart';
import 'package:flutter_dropdown_alert/model/data_alert.dart';
// import 'package:flutter_incall_manager/flutter_incall_manager.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:zebra/app/controller/MainPageController.dart';
import 'package:zebra/help/loadingClass.dart';
import '../Repository/CallApi.dart';
import '../url/url.dart';
import 'package:proximity_sensor/proximity_sensor.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:zebra/help/globals.dart' as globals;






class CallController extends GetxController with GetSingleTickerProviderStateMixin, LoadingDialog{



  MainPageController mainPageController = Get.find();
  final localRenderer = RTCVideoRenderer();
  final remoteRenderer = RTCVideoRenderer();
  late MediaStream localStream;
  late RTCPeerConnection pc;
  RxBool isNear = false.obs;
  late Socket socket;
  RxBool socketConnected = false.obs;
  RxBool callAccepted = true.obs;
  RxBool imCaller = false.obs;
  RxBool speaker = false.obs;
  RxBool hideDeal = false.obs;
  RxBool isFirstAudio = true.obs;
  String socketRoom = '';
  String name = '';
 // late StreamSubscription<dynamic> _streamSubscription;
  //AudioInput currentInput = const AudioInput("unknow", 0);
  late CustomTimerController timerController ;
  bool isActive = true;
  RxBool looping = true.obs;
  RxInt callPageCallId = 0.obs;
  RxInt otherUserId = 0.obs;







  Future init() async{
    await localRenderer.initialize();
    await remoteRenderer.initialize();
    await initSocket();
    await joinRoom();
   // listenSensor();
    init1();
  }



  initSocket()async{
    socket = io(Urls.callSocket, OptionBuilder().enableForceNewConnection().setTransports(['websocket']).setQuery({"id": socketRoom.toString()}).build());
    socket.onConnect((_) {socketConnected.value = true;});
    socket.onDisconnect((_) {socketConnected.value = false;});
    socket.on('joined', (data){
      _sendOffer();
    });
    socket.on('offer', (data) async{
      data = jsonDecode(data);
      await _gotOffer(RTCSessionDescription(data['sdp'], data['type']));
      await _sendAnswer();
    });
    socket.on('answer', (data){
      data = jsonDecode(data);
      _gotAnswer(RTCSessionDescription(data['sdp'], data['type']));
    });
    socket.on('ice', (data)async{
      data = jsonDecode(data);
      _gotIce(RTCIceCandidate(data['candidate'], data['sdpMid'], data['sdpMLineIndex']));
      // await IncallManager().setSpeakerphoneOn(false);
      timerController.start();
      FlutterRingtonePlayer.stop();
      looping.value ? callAnswerApi() : null;
    });
    socket.connect();
  }



  callAnswerApi(){
    looping.value = false;
    for(var x in mainPageController.callId){
      if(x.containsKey(otherUserId.value)){
        callPageCallId.value = x[otherUserId.value];
        x[otherUserId.value] == null ? null : looping.value = false;
        CallApi().userAnswerApi(callId: x[otherUserId.value]);
      }
    }
  }



  dealWork(){
    showDialogBox();
    CallApi().userDealApi(callId: callPageCallId.value).then((value){
      hideDialog();
      AlertController.show("Deal", "work deal successfully done", TypeAlert.success);
      hideDeal.value = true;
    },onError: (e){
      AlertController.show("Deal", "Error! try again...", TypeAlert.error);
      hideDialog();
    });
  }


  Future joinRoom() async{
    final config = {
      'iceServers': [
        {"url": "stun:stun.l.google.com:19302"},
      ]
    };
    final sdpConstraints = {
      'mandatory':{
        'OfferToReceiveAudio': true,
        'OfferToReceiveVideo': false,
      },
      'optional':[]
    };
    pc = await createPeerConnection(config, sdpConstraints);
    final mediaConstraints = {
      'audio': true,
      'video': false
    };
    localStream = await Helper.openCamera(mediaConstraints);
    localStream.getTracks().forEach((track) {
      pc.addTrack(track, localStream);
    });
    localRenderer.srcObject = localStream;
    pc.onIceCandidate = (ice) {
      _sendIce(ice);
    };
    pc.onAddStream = (stream){
      remoteRenderer.srcObject = stream;
    };
    socket.emit('join');
  }



  Future _sendOffer() async{
    var offer = await pc.createOffer();
    pc.setLocalDescription(offer);
    socket.emit('offer', jsonEncode(offer.toMap()));
  }
  Future _gotOffer(RTCSessionDescription offer) async{
    pc.setRemoteDescription(offer);
  }
  Future _sendAnswer() async{
    var answer = await pc.createAnswer();
    pc.setLocalDescription(answer);
    socket.emit('answer', jsonEncode(answer.toMap()));
  }
  Future _gotAnswer(RTCSessionDescription answer) async{
    pc.setRemoteDescription(answer);
  }
  Future _sendIce(RTCIceCandidate ice) async{
    socket.emit('ice', jsonEncode(ice.toMap()));
  }
  Future _gotIce(RTCIceCandidate ice) async{
    pc.addCandidate(ice);
  }


  @override
  void onInit() {
    timerController = CustomTimerController(
        vsync: this,
        begin: const Duration(seconds: 0),
        end: const Duration(seconds: 200),
        initialState: CustomTimerState.reset,
        interval: CustomTimerInterval.milliseconds
    );
    globals.callOpen = true;
    super.onInit();
    socketRoom = Get.arguments[0]["socketChannel"];
    name = Get.arguments[2]["name"];
    otherUserId.value = Get.arguments[1]["id"];
    socketRoom == '' ? null : init();
  }




  @override
  void onClose() {
    globals.callOpen = false;
    if(socketConnected.value){
      socket.disconnect();
      socket.destroy();
      socket.dispose();
      pc.dispose();
      timerController.dispose();
     // _streamSubscription.cancel();
     // _streamSubscription.pause();
      isActive = false;
    }else{}
    super.onClose();
  }






  Future<void> listenSensor() async {
    FlutterError.onError = (FlutterErrorDetails details) {
      if (foundation.kDebugMode) {
        FlutterError.dumpErrorToConsole(details);
      }
    };
    // _streamSubscription = ProximitySensor.events.listen((int event) {
    //     callAccepted.value = true;
    //     isActive ? isNear.value = (event > 0) ? true : false : false;
    //     isActive ? isNear.value ? IncallManager().turnScreenOn() : IncallManager().turnScreenOff() : IncallManager().turnScreenOn();
    // });
  }


  Future<void> init1() async {
    //timerController.start(disableNotifyListeners: true);
    // FlutterAudioManager.setListener(() async {
    //   await _getInput();
    //   update();
    // });
    await _getInput();
  }


  _getInput() async {
  //  await FlutterAudioManager.changeToReceiver();
 // GetPlatform.isAndroid ? currentInput = await FlutterAudioManager.getCurrentOutput() : null;
  }



  soundOutPut()async{
    // if (currentInput.port == AudioPort.receiver) {
    //   await FlutterAudioManager.changeToSpeaker();
    // } else {
    //   await FlutterAudioManager.changeToReceiver();
    // }
    await _getInput();
      speaker.value = !speaker.value;
    // speaker.value ? await IncallManager().setSpeakerphoneOn(true) : await IncallManager().setSpeakerphoneOn(false);
  }


  void toggleAudio() async {
    if (localStream == null) throw Exception('Stream is not initialized');
    Helper.setMicrophoneMute(isFirstAudio.value, localStream.getAudioTracks().first);
      isFirstAudio.value = !isFirstAudio.value;
  }


  callingSound()async{
    await FlutterRingtonePlayer.play(fromAsset: "assets/call.mp3", looping: true, asAlarm: false);
  }


  @override
  void onReady() {
    super.onReady();
    callingSound();
  }




}