import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controller/chat_controller/chat_controller.dart';

class ChatHistoryScreen extends StatelessWidget {
  final ChatController chatController = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat History'),
      ),
      body: Obx(
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
                    color: isUser ? Colors.blue : Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    message['text']!,
                    style:
                        TextStyle(color: isUser ? Colors.white : Colors.black),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
