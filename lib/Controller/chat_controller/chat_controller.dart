import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ChatMessage {
  final int? id;
  final String sender;
  final String text;
  final DateTime timestamp;

  ChatMessage({
    this.id,
    required this.sender,
    required this.text,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'sender': sender,
      'text': text,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  static ChatMessage fromMap(Map<String, dynamic> map) {
    return ChatMessage(
      id: map['id'],
      sender: map['sender'],
      text: map['text'],
      timestamp: DateTime.parse(map['timestamp']),
    );
  }
}

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'chat_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE messages(id INTEGER PRIMARY KEY AUTOINCREMENT, sender TEXT, text TEXT, timestamp TEXT)',
        );
      },
    );
  }

  Future<void> insertMessage(ChatMessage message) async {
    final db = await database;
    await db.insert(
      'messages',
      message.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<ChatMessage>> getMessages() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('messages');
    return List.generate(maps.length, (i) {
      return ChatMessage.fromMap(maps[i]);
    });
  }
}

class ChatController extends GetxController {
  final RxList<Map<String, String>> messages = <Map<String, String>>[].obs;
  final TextEditingController textController = TextEditingController();
  final RxBool isLoading = false.obs;
  final model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: "AIzaSyBXpN8meXDisWp630UyWbop3hXJI5QTrTI");
  final DatabaseHelper databaseHelper = DatabaseHelper();

  @override
  void onInit() {
    super.onInit();
    loadChatHistory();
  }

  Future<void> loadChatHistory() async {
    final chatMessages = await databaseHelper.getMessages();
    messages.addAll(chatMessages.map((msg) => {
          'sender': msg.sender,
          'text': msg.text,
        }));
  }

  Future<void> sendMessage(String message) async {
    if (message.isEmpty) return;
    final userMessage = ChatMessage(
      sender: 'user',
      text: message,
      timestamp: DateTime.now(),
    );
    await databaseHelper.insertMessage(userMessage);

    messages.add({'sender': 'user', 'text': message});
    textController.clear();
    isLoading.value = true;

    try {
      
      final content = [Content.text(message)];
      final response = await model.generateContent(content);
     

      if (response.text != null && response.text!.isNotEmpty) {
        final aiMessage = response.text!.trim();

        final aiChatMessage = ChatMessage(
          sender: 'ai',
          text: aiMessage,
          timestamp: DateTime.now(),
        );
        await databaseHelper.insertMessage(aiChatMessage);

        messages.add({'sender': 'ai', 'text': aiMessage});
      } else {
        messages
            .add({'sender': 'ai', 'text': 'Error: Unable to fetch response.'});
      }
    } catch (e) {
      print('Error: Unable to fetch response. Exception: $e');

      messages.add({
        'sender': 'ai',
        'text': 'Error: Unable to fetch response. Exception: $e'
      });
    } finally {
      isLoading.value = false;
    }
  }
}
