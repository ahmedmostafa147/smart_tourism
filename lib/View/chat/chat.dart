import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_tourism/Controller/chat_controller/chat_controller.dart';
import 'package:smart_tourism/View/Auth/AuthWidget/text_form_field.dart';
import 'package:intl/intl.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class ChatScreen extends StatelessWidget {
  final ChatController chatController = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AI Chat'),
      ),
      body: Obx(
        () => chatController.isLoadingHistory.value
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Expanded(
                    child: Obx(
                      () => ListView.builder(
                        itemCount: chatController.messages.length,
                        itemBuilder: (context, index) {
                          final message = chatController.messages[index];
                          final isUser = message['sender'] == 'user';
                          final timestamp =
                              DateTime.parse(message['timestamp'].toString());

                          return ListTile(
                            title: Column(
                              crossAxisAlignment: isUser
                                  ? CrossAxisAlignment.end
                                  : CrossAxisAlignment.start,
                              children: [
                                buildMessageContainer(
                                  isUser,
                                  message['text']!,
                                  timestamp,
                                  context,
                                  index,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
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
                          SizedBox(width: 10.w),
                          Obx(
                            () => chatController.isLoading.value
                                ? CircularProgressIndicator(
                                    color: Colors.teal,
                                    strokeWidth: 2,
                                  )
                                : IconButton(
                                    icon: Icon(
                                      Icons.send,
                                      size: 30.r,
                                    ),
                                    onPressed: () {
                                      chatController.sendMessage(
                                          chatController.textController.text);
                                    },
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget buildMessageContainer(bool isUser, String text, DateTime timestamp,
      BuildContext context, int index) {
    final timeString = DateFormat('HH:mm').format(timestamp);
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: isUser ? Colors.teal : Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment:
              isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            buildMarkdownText(text, isUser),
            SizedBox(height: 5),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isUser)
                  IconButton(
                    icon: Icon(Icons.copy, size: 20.r),
                    onPressed: () {
                      copyText(context, text);
                    },
                  ),
                if (isUser)
                  IconButton(
                    icon: Icon(Icons.edit, size: 20.r),
                    onPressed: () {
                      editText(context, index, text);
                    },
                  ),
                Text(
                  timeString,
                  style: TextStyle(
                    color: isUser ? Colors.white60 : Colors.black54,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMarkdownText(String text, bool isUser) {
    return MarkdownBody(
      data: text,
      styleSheet: MarkdownStyleSheet(
        p: TextStyle(
          color: isUser ? Colors.white : Colors.black,
        ),
        strong: TextStyle(
          color: Colors.teal,
        ),
        em: TextStyle(
          color: Colors.teal,
        ),
        code: TextStyle(
          color: Colors.teal,
        ),
      ),
    );
  }

  void copyText(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    Get.snackbar('Copied', 'Message copied to clipboard');
  }

  void editText(BuildContext context, int index, String text) {
    chatController.textController.text = text;

    // Update the edited message text
    chatController.messages[index]['text'] = text;
  }
}
