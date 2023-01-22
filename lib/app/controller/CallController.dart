import 'dart:async';
import 'dart:convert';
//import 'package:advanced_audio_manager/advanced_audio_manager.dart';
import 'package:custom_timer/custom_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_incall_manager/flutter_incall_manager.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:zebra/help/loadingClass.dart';
import '../url/url.dart';
import 'package:proximity_sensor/proximity_sensor.dart';
import 'package:flutter/foundation.dart' as foundation;







class CallController extends GetxController with LoadingDialog{


  final localRenderer = RTCVideoRenderer();
  final remoteRenderer = RTCVideoRenderer();
  late MediaStream localStream;
  late RTCPeerConnection pc;
  RxBool isNear = false.obs;
  late Socket socket;
  RxBool socketConnected = false.obs;
  RxBool callAccepted = false.obs;
  RxBool imCaller = true.obs;
  RxBool speaker = false.obs;
  RxBool isFirstAudio = true.obs;
  String socketRoom = '';
  late StreamSubscription<dynamic> _streamSubscription;
  //AudioInput currentInput = const AudioInput("unknow", 0);
  final CustomTimerController timerController = CustomTimerController();
  bool isActive = true;








  Future init() async{
    await localRenderer.initialize();
    await remoteRenderer.initialize();
    await initSocket();
    await joinRoom();
    listenSensor();
    init1();
  }



  initSocket(){
    socket = io(Urls.callSocket, OptionBuilder().setTransports(['websocket']).setQuery({"id": socketRoom}).build());
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
    socket.on('ice', (data){
      data = jsonDecode(data);
      _gotIce(RTCIceCandidate(data['candidate'], data['sdpMid'], data['sdpMLineIndex']));
    });
    socket.connect();
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
    super.onInit();
    socketRoom = Get.arguments[0]["socketChannel"];
    init();
  }




  @override
  void onClose() {
    if(socketConnected.value){
      socket.disconnect();
      socket.destroy();
      socket.dispose();
      pc.dispose();
      timerController.dispose();
      _streamSubscription.cancel();
      _streamSubscription.pause();
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
    _streamSubscription = ProximitySensor.events.listen((int event) {
        callAccepted.value = true;
        isActive ? isNear.value = (event > 0) ? true : false : false;
        isActive ? isNear.value ? IncallManager().turnScreenOn() : IncallManager().turnScreenOff() : IncallManager().turnScreenOn();
    });
  }


  Future<void> init1() async {
    timerController.start(disableNotifyListeners: true);
    // FlutterAudioManager.setListener(() async {
    //   await _getInput();
    //   update();
    // });
    await _getInput();
  }


  _getInput() async {
  // currentInput = await FlutterAudioManager.getCurrentOutput();
  }



  soundOutPut()async{
    // if (currentInput.port == AudioPort.receiver) {
    //   await FlutterAudioManager.changeToSpeaker();
    // } else {
    //   await FlutterAudioManager.changeToReceiver();
    // }
    await _getInput();
      speaker.value = !speaker.value;
  }


  void toggleAudio() async {
    if (localStream == null) throw Exception('Stream is not initialized');
    Helper.setMicrophoneMute(isFirstAudio.value, localStream.getAudioTracks().first);
      isFirstAudio.value = !isFirstAudio.value;
  }






}