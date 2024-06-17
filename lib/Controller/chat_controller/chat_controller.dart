import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ChatMessage {
  final String sender;
  final String text;
  final DateTime timestamp;

  ChatMessage({
    required this.sender,
    required this.text,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'sender': sender,
      'text': text,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  static ChatMessage fromMap(Map<String, dynamic> map) {
    return ChatMessage(
      sender: map['sender'],
      text: map['text'],
      timestamp: DateTime.parse(map['timestamp']),
    );
  }
}

class ChatController extends GetxController {
  final RxList<Map<String, String>> messages = <Map<String, String>>[].obs;
  final TextEditingController textController = TextEditingController();
  final RxBool isLoading = false.obs;
  final model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: "AIzaSyBXpN8meXDisWp630UyWbop3hXJI5QTrTI");

  @override
  void onInit() {
    super.onInit();
    loadChatHistory();
  }

  Future<void> loadChatHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? messagesJson = prefs.getString('chat_messages');
    if (messagesJson != null) {
      List<dynamic> messagesList = jsonDecode(messagesJson);
      messages.value = messagesList
          .map((msg) => {
                'sender': msg['sender'],
                'text': msg['text'],
              })
          .toList()
          .cast<Map<String, String>>();
    }
  }

  Future<void> saveChatHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> messagesList = messages
        .map((msg) => {
              'sender': msg['sender'],
              'text': msg['text'],
            })
        .toList();
    String messagesJson = jsonEncode(messagesList);
    await prefs.setString('chat_messages', messagesJson);
  }

  String processSpecialSymbols(String text) {
    return text.replaceAll('*#', '<symbol-function>');
  }

  Future<void> sendMessage(String message) async {
    if (message.isEmpty) return;
    final userMessage = {
      'sender': 'user',
      'text': message,
    };
    messages.add(userMessage);
    textController.clear();
    isLoading.value = true;

    await saveChatHistory();

    try {
      final content = [Content.text(message)];
      final response = await model.generateContent(content);

      if (response.text != null && response.text!.isNotEmpty) {
        final aiMessage = processSpecialSymbols(response.text!.trim());

        final aiMessageMap = {
          'sender': 'ai',
          'text': aiMessage,
        };

        messages.add(aiMessageMap);
        await saveChatHistory();
      } else {
        messages.add({
          'sender': 'ai',
          'text': 'Error: Unable to fetch response.',
        });
      }
    } catch (e) {
      print('Error: Unable to fetch response. Exception: $e');

      messages.add({
        'sender': 'ai',
        'text': 'Error: Unable to fetch response. Exception: $e',
      });
    } finally {
      isLoading.value = false;
    }
  }
}
