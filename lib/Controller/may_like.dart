import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_tourism/Core/End%20Points/endpoints.dart';

class MayLikedController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxList<String> mayLikedItems = <String>[].obs;

  Future<void> fetchMayLikedItems() async {
    try {
      isLoading.value = true;

      // Get the authentication token from shared preferences
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      // Make sure token exists
      if (token == null) {
        throw 'User is not logged in';
      }

      // Send the request to fetch may liked items with the authentication token in the headers
      final Uri url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.mayLikedItems);
      final http.Response response = await http.get(
        url,
        headers: <String, String>{
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      // Check the response status code
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        mayLikedItems.clear();
        mayLikedItems.addAll(data['data']);
      } else {
        throw 'Failed to fetch may liked items: ${response.statusCode}';
      }
    } catch (error) {
      Get.snackbar("Error", error.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }
}