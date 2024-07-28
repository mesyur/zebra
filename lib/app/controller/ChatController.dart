import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:zebra/help/hive/localStorage.dart';
import '../../help/GetStorage.dart';
import '../../help/loadingClass.dart';
import '../Repository/ChatApi.dart';
import '../model/ChatMessagesModel.dart';
import '../model/Global.dart';
import 'InitialController.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;


class ChatController extends GetxController with LoadingDialog{

  Rxn<ChatMessagesModel> chatMessagesModel = Rxn<ChatMessagesModel>();
  RxString chatId = ''.obs;
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



  getMessage(){
    chatId.value == '0' ? null : showDialogBox();
    chatId.value == '0' ? null : ChatApi().getMessage(data: jsonEncode({
      "chatId": chatId.value
    })).then((value){
      chatMessagesModel.value = value;
      for(var i in value.data){
        final textMessage = types.TextMessage(
          author: types.User(
              id: i.author.id.toString(),
              firstName: i.author.firstName,
              lastName: i.author.lastName,
              imageUrl: 'https://i.ibb.co/jWh4nty/appLogo.png',
              createdAt: 1720363983021
          ),
          createdAt: int.tryParse(i.createdAt),
          id: i.id.toString(),
          text: i.text,
        );
        messages.insert(0, textMessage);
      }
      Get.back();
    },onError: (e){
      Get.back();
    });
  }


  @override
  void onInit() {
    addMsgController = TextEditingController();
    chatId.value = Get.arguments[1].toString();
    super.onInit();
  }

  @override
  void onClose() {
    addMsgController.dispose();
    Global.otherUserGlobalIdForChat.value = 0;
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
    Global.otherUserGlobalIdForChat.value = Get.arguments[0];
    getMessage();
  }


}







