import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
                    title: Column(
                      crossAxisAlignment: isUser
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        buildMessageContainer(isUser, message['text']!),
                        if (isUser)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: Icon(Icons.copy, size: 20.r),
                                onPressed: () {
                                  copyText(context, message['text']!);
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.edit, size: 20.r),
                                onPressed: () {
                                  editText(context, index, message['text']!);
                                },
                              ),
                            ],
                          ),
                      ],
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
              borderRadius: BorderRadius.circular(20),
            ),
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
                      chatController.sendMessage(chatController.textController.text);
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

  void copyText(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    Get.snackbar('Copied', 'Message copied to clipboard');
  }

  void editText(BuildContext context, int index, String text) {
    chatController.textController.text = text;
    chatController.messages.removeAt(index);
  }

  Widget buildMessageContainer(bool isUser, String text) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isUser ? Colors.teal : Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
        ),
        child: isUser
            ? Text(
                text,
                style: TextStyle(color: Colors.white),
              )
            : buildRichText(text),
      ),
    );
  }

  Widget buildRichText(String text) {
    final spans = <TextSpan>[];
    final lines = text.split('\n');

    for (var line in lines) {
      if (line.startsWith('*')) {
        spans.add(
          TextSpan(
            text: line.replaceAll('*', '').trim(),
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        );
      } else {
        spans.add(
          TextSpan(
            text: line,
          ),
        );
      }
      spans.add(TextSpan(text: '\n')); // Add a new line after each line
    }

    return RichText(
      text: TextSpan(
        style: TextStyle(color: Colors.black),
        children: spans,
      ),
    );
  }
}
