import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_tourism/Core/End%20Points/endpoints.dart';

class ChatController extends GetxController {
  final RxList<Map<String, dynamic>> messages = <Map<String, dynamic>>[].obs;
  final TextEditingController textController = TextEditingController();
  final RxBool isLoading = false.obs;
  final RxBool isLoadingHistory = true.obs;

  final model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: "AIzaSyBXpN8meXDisWp630UyWbop3hXJI5QTrTI");
  final String chatQuestionUrl =
      ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.QuestionChat;
  final String chatResponseUrl =
      ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.ResponseChat;
  final String chatHistoryQuestionUrl =
      ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.getChatHistoryQuestion;
  final String chatHistoryResponseUrl =
      ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.getChatHistoryResponse;

  @override
  void onInit() {
    super.onInit();
    loadChatHistory();
  }

  Future<void> loadChatHistory() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    if (token == null) {
      throw 'User is not logged in';
    }

    final responseQuestions = await http.get(
      Uri.parse(chatHistoryQuestionUrl),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
    );

    final responseResponses = await http.get(
      Uri.parse(chatHistoryResponseUrl),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
    );

    if (responseQuestions.statusCode == 200 &&
        responseResponses.statusCode == 200) {
      final List<dynamic> questionHistory = jsonDecode(responseQuestions.body);
      final List<dynamic> responseHistory = jsonDecode(responseResponses.body);

      final List<Map<String, dynamic>> combinedHistory = [];

      for (var item in questionHistory) {
        combinedHistory.add({
          'sender': 'user',
          'text': item['question_text'] ?? '',
          'timestamp': DateTime.parse(item['timestamp']),
        });
      }

      for (var item in responseHistory) {
        combinedHistory.add({
          'sender': 'ai',
          'text': item['response_text'] ?? '',
          'timestamp': DateTime.parse(item['timestamp']),
        });
      }

      combinedHistory.sort((a, b) => a['timestamp'].compareTo(b['timestamp']));
      messages.assignAll(combinedHistory);
    } else {
      print('Failed to load chat history');
    }
    isLoadingHistory.value = false;
  }

  Future<void> sendMessage(String message) async {
    if (message.isEmpty) return;
    final userMessage = {
      'sender': 'user',
      'text': message,
      'timestamp': DateTime.now(),
    };

    await sendChatQuestionToBackend(message);

    messages.add(userMessage);
    textController.clear();
    isLoading.value = true;

    try {
      final content = [Content.text(message)];
      final response = await model.generateContent(content);

      if (response.text != null && response.text!.isNotEmpty) {
        final aiMessage = response.text!.trim();
        final aiChatMessage = {
          'sender': 'ai',
          'text': aiMessage,
          'timestamp': DateTime.now(),
        };

        await sendChatResponseToBackend(aiMessage);

        messages.add(aiChatMessage);
      } else {
        messages.add({
          'sender': 'ai',
          'text': 'Error: Unable to fetch response.',
          'timestamp': DateTime.now(),
        });
      }
    } catch (e) {
      print('Error: Unable to fetch response. Exception: $e');
      messages.add({
        'sender': 'ai',
        'text': 'Error: Unable to fetch response. Exception: $e',
        'timestamp': DateTime.now(),
      });
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> sendChatQuestionToBackend(String question) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    if (token == null) {
      throw 'User is not logged in';
    }

    final response = await http.post(
      Uri.parse(chatQuestionUrl),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
      body: jsonEncode({'question_text': question}),
    );

    if (response.statusCode != 200) {
      print('Failed to send question to backend');
    }
  }

  Future<void> sendChatResponseToBackend(String responseText) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    if (token == null) {
      throw 'User is not logged in';
    }

    final response = await http.post(
      Uri.parse(chatResponseUrl),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
      body: jsonEncode({'response_text': responseText}),
    );

    if (response.statusCode != 200) {
      print('Failed to send response to backend');
    }
  }
}
