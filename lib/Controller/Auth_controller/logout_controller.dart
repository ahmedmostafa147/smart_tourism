import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_tourism/View/Auth/Login/login.dart';
import '../../Core/End%20Points/endpoints.dart';

class LogoutController extends GetxController {
  final RxBool isLoading = false.obs;

  Future<void> logout() async {
    try {
      isLoading.value = true;

      // Get the authentication token from shared preferences
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      // Make sure token exists
      if (token == null) {
        throw 'User is not logged in';
      }

      // Send the logout request with the authentication token in the headers
      final Uri url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.logoutEmail);
      final http.Response response = await http.post(
        url,
        headers: <String, String>{
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      // Check the response status code
      if (response.statusCode == 200) {
        // Clear token from shared preferences
        await prefs.remove('token');
        Get.snackbar("Success", "Logout Success",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.teal,
            colorText: Colors.white);
        // Navigate to login screen
        Get.offAll(() => LoginView());
      } else {
         var responseBody = jsonDecode(response.body);
        var errorMessage = responseBody["message"];
        throw 'Logout failed: $errorMessage';
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
