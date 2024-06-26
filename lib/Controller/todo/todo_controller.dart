import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_tourism/Core/End%20Points/endpoints.dart';
import 'package:http/http.dart' as http;

class Todo {
  final int id;
  final String title;
  final String content;

  Todo({
    required this.id,
    required this.title,
    required this.content,
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['Id'],
      title: json['Title'],
      content: json['Content'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Title': title,
      'Content': content,
    };
  }
}

class TodoController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxBool isLoadingSave = false.obs;
  final RxBool isDeleting = false.obs;
  final RxList<Todo> todos = <Todo>[].obs;

  Future<void> postToDo(String title, String content) async {
    final url = ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.notes;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    if (token == null) {
      Get.snackbar("Error", "User is not logged in");
      return;
    }

    try {
      isLoading.value = true;

      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Authorization": "Bearer $token",
          'Content-Type': 'application/json'
        },
        body: jsonEncode({
          'Title': title,
          'Content': content,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        todos.add(Todo.fromJson(data));
        Get.snackbar("Success", "Data added successfully");
      } else {
        Get.snackbar("Error", "Failed to add data: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to add data: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getToDo() async {
    final url = ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.getNotes;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    if (token == null) {
      Get.snackbar("Error", "User is not logged in");
      return;
    }

    try {
      isLoadingSave.value = true;
      final response = await http.get(
        Uri.parse(url),
        headers: {
          "Authorization": "Bearer $token",
          'Content-Type': 'application/json'
        },
      );

      if (response.statusCode == 200) {
        isLoadingSave.value = false;
        final List<dynamic> data = json.decode(response.body);
        todos.value = data.map((e) => Todo.fromJson(e)).toList();
        Get.snackbar("Success", "Data fetched successfully");
      } else {
        isLoadingSave.value = false;
        Get.snackbar("Error", "Failed to fetch data: ${response.statusCode}");
      }
    } catch (e) {
      isLoadingSave.value = false;
      Get.snackbar("Error", "Failed to fetch data: $e");
    } finally {
      isLoadingSave.value = false;
    }
  }

  Future<void> deleteToDo(int id) async {
    final url = "https://zoz-rwob.onrender.com/delete_notes/?note_id=$id";
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    if (token == null) {
      Get.snackbar("Error", "User is not logged in");
      return;
    }

    try {
      isDeleting.value = true;
      final response = await http.delete(
        Uri.parse(url),
        headers: {
          "Authorization": "Bearer $token",
          'Content-Type': 'application/json'
        },
      );

      if (response.statusCode == 200) {
        isDeleting.value = false;
        todos.removeWhere((todo) => todo.id == id);
        Get.snackbar("Success", "Data deleted successfully");
      } else {
        isDeleting.value = false;
        Get.snackbar("Error", "Failed to delete data: ${response.statusCode}");
      }
    } catch (e) {
      isDeleting.value = false;
      Get.snackbar("Error", "Failed to delete data: $e");
    }
  }
}
