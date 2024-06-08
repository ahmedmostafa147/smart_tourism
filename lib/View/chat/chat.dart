import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_tourism/Controller/chat_controller/chat_controller.dart';
import 'package:smart_tourism/View/Auth/AuthWidget/text_form_field.dart';

class ChatScreen extends StatelessWidget {
  final ChatController chatController = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AI Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: chatController.messages.length,
                itemBuilder: (context, index) {
                  final message = chatController.messages[index];
                  final isUser = message['sender'] == 'user';
                  return ListTile(
                    title: Align(
                      alignment:
                          isUser ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: isUser ? Colors.teal : Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          message['text']!,
                          style: TextStyle(
                              color: isUser ? Colors.white : Colors.black),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Obx(
            () => chatController.isLoading.value
                ? CircularProgressIndicator()
                : SizedBox.shrink(),
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.blueGrey[900],
                // border: Border.all(color: Colors.grey, width: 1.0),
                borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: CustomTextForm(
                      hintText: 'Type a message...',
                      controller: chatController.textController,
                      labelText: 'Message',
                      isPassword: false,
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.send,
                      size: 30.r,
                    ),
                    onPressed: () {
                      chatController
                          .sendMessage(chatController.textController.text);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
