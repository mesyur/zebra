import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:zebra/app/controller/ChatController.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:intl/intl.dart' as intl;

import '../../../help/hive/localStorage.dart';

class ChatPage extends GetView<ChatController>{
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Murad Najm'),
        centerTitle: true,
        elevation: 5,
        scrolledUnderElevation: 5,
        surfaceTintColor: Colors.white,
        actions: const [
          Icon(Icons.more_horiz),
          SizedBox(width: 10),
        ],
      ),
      body: Obx(() => Chat(
        user: controller.user,
        messages: [...controller.messages],
        onSendPressed: controller.handleSendPressed,
        showUserAvatars: true,
        showUserNames: true,
        customBottomWidget: Column(
          children: [

            SizedBox(
              width: Get.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                child: Wrap(
                  runSpacing: 2,
                  spacing: 2,
                  children: List.generate(controller.staticChat.length, (index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 0),
                    child: SizedBox(
                      height: 30,
                      child: MaterialButton(
                        minWidth: 12,
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        elevation: 0,
                        color: Colors.white,
                        shape: const RoundedRectangleBorder(side: BorderSide(color: Colors.black12), borderRadius: BorderRadius.all(Radius.circular(5.0))),
                        onPressed: (){
                          final textMessage = types.TextMessage(
                            author: controller.user,
                            createdAt: DateTime.now().millisecondsSinceEpoch,
                            id: const Uuid().v4(),
                            text: '${controller.staticChat[index]}',
                          );
                          controller.messages.insert(0, textMessage);
                          controller.initialController.socket.emit('chat',[{
                            'id' : Get.arguments,
                            'msg' : textMessage
                          }]);



                          print(jsonEncode({
                            "author": {
                              "id": int.parse(textMessage.author.id), // sender id / my id
                              "firstName": textMessage.author.firstName,
                              "lastName": textMessage.author.lastName,
                              "imageUrl": "https://i.ibb.co/jWh4nty/appLogo.png",
                              "createdAt": textMessage.author.createdAt
                            },
                            "id": textMessage.id,
                            "userId": Get.arguments, // other user id
                            "text": textMessage.text,
                            "type": "text",
                            "createdAt": textMessage.author.createdAt
                          }));

                          print(LocalStorage().getValue("token"));

                          controller.addMsgController.clear();
                        },
                        child: Text('${controller.staticChat[index]}', style: const TextStyle(color: Colors.black87, fontSize: 12.0, fontWeight: FontWeight.bold),),
                      ),
                    ),
                  )),
                ),
              ),
            ),



            Row(
              children: [


                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(right: 10),
                    margin: const EdgeInsets.only(left: 10,bottom: 5),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black45),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Directionality(
                            textDirection: Get.locale?.languageCode == "ar" ? TextDirection.rtl : TextDirection.ltr,
                            child: GestureDetector(
                              child: TextField(
                                controller: controller.addMsgController,
                                textDirection: isRTL(controller.addMsgController.text) ? TextDirection.rtl : TextDirection.ltr,
                                decoration: InputDecoration(hintTextDirection: isRTL(controller.addMsgController.text) ? TextDirection.rtl : TextDirection.ltr,
                                    hintText: " Aa",
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                                    border: InputBorder.none),
                                onChanged: (x){
                                  controller.addMsgControllerText.value = x;
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),


                const SizedBox(width: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: (){
                        final textMessage = types.TextMessage(
                          author: controller.user,
                          createdAt: DateTime.now().millisecondsSinceEpoch,
                          id: const Uuid().v4(),
                          text: controller.addMsgController.text,
                        );
                        controller.messages.insert(0, textMessage);
                        controller.initialController.socket.emit('chat',[{
                          'id' : Get.arguments,
                          'msg' : textMessage
                        }]);
                        controller.addMsgControllerText.value = '';
                        controller.addMsgController.clear();
                      },
                      child: Icon(Icons.send_rounded,color: controller.addMsgControllerText.value == '' ? Colors.grey : Colors.blue)
                  ),
                ),


              ],
            )
          ],
        ),
      )),
    );
  }
  bool isRTL(String text){
    return intl.Bidi.detectRtlDirectionality(text);
  }
}




/*
class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<types.Message> _messages = [];
  final _user = const types.User(
    id: '82091008-a484-4a89-ae75-a22bf8d6f3ac',
  );
  final _user2 = const types.User(
        firstName: "Janice",
        id: "e52552f4-835d-4dbe-ba77-b076e659774d",
        imageUrl: "https://i.pravatar.cc/300?u=e52552f4-835d-4dbe-ba77-b076e659774d",
        lastName: "King"
  );

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Chat(
      messages: _messages,
      onSendPressed: _handleSendPressed,
      showUserAvatars: true,
      showUserNames: true,
      user: _user,
    ),
  );

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }









  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user2,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
    );
    _addMessage(textMessage);
  }

  void _loadMessages() async {
    final response = await rootBundle.loadString('assets/messages.json');
    final messages = (jsonDecode(response) as List)
        .map((e) => types.Message.fromJson(e as Map<String, dynamic>))
        .toList();

    setState(() {
      _messages = messages;
    });
  }
}
*/
