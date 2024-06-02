import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import '../../Core/End%20Points/endpoints.dart';

class ChangePasswordController extends GetxController {
  final RxBool isLoading = false.obs;

  Future<void> changePassword(
      String currentPassword, String newPassword) async {
    try {
      isLoading.value = true;

      // Get the authentication token from shared preferences
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      final Uri url = Uri.parse(ApiEndPoints.baseUrl +
          ApiEndPoints.authEndpoints.changePassword +
          '?current_password=$currentPassword&new_password=$newPassword');

      final http.Response response = await http.put(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'current_password': currentPassword,
          'new_password': newPassword,
        }),
      );

      if (response.statusCode == 200) {
        Get.snackbar("Success", "Password Changed Successfully",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.teal,
            colorText: Colors.white);
      } else {
        var responseBody = jsonDecode(response.body);
        var errorMessage = responseBody["message"];
        throw 'Password change failed: $errorMessage';
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
