import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:zebra/help/hive/localStorage.dart';
import '../../help/loadingClass.dart';
import 'InitialController.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;


class ChatController extends GetxController with LoadingDialog{


  InitialController initialController = Get.find();
  RxList messages = [].obs;
  late TextEditingController addMsgController;
  RxString addMsgControllerText = ''.obs;
  List staticChat = [
    'Merhaba !',
    'Ne zaman müsaitsiniz ?',
    'Tamam',
    'Bilgi almak istiyorum.',
    'Evet',
    'Hayır',
    'Dönüş sağlayacağım',
  ];


  final user = types.User(
      id: LocalStorage().getValue("id").toString(),
      firstName: LocalStorage().getValue("firstName"),
      lastName: LocalStorage().getValue("lastName"),
      imageUrl: 'https://i.ibb.co/jWh4nty/appLogo.png',
      createdAt: DateTime.now().millisecondsSinceEpoch
  );


  void handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
    );
    messages.insert(0, textMessage);
    initialController.socket.emit('chat',[{
      'id' : Get.arguments,
      'msg' : textMessage
    }]);
  }


  @override
  void onInit() {
    addMsgController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    addMsgController.dispose();
    super.onClose();
  }



  @override
  void onReady() {
    super.onReady();
    initialController.socket.on("chat", (data) {
      final textMessage = types.TextMessage(
        author: types.User(
            id: data['data']['msg']['author']['id'],
            firstName: data['data']['msg']['author']['firstName'],
            lastName: data['data']['msg']['author']['lastName'],
            imageUrl: 'https://i.ibb.co/jWh4nty/appLogo.png',
            createdAt: data['data']['msg']['createdAt']
        ),
        createdAt: data['data']['msg']['createdAt'],
        id: data['data']['msg']['id'],
        text: data['data']['msg']['text'],
      );
      messages.insert(0, textMessage);
    });
  }


}







