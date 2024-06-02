import 'dart:convert';

import 'package:get/get.dart';
import '../../Core/End%20Points/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ResetPasswordController extends GetxController {
  final RxBool isLoading = false.obs;

  Future<void> resetPassword(String userIdentifier, String newPassword) async {
    try {
      isLoading.value = true;

      final Uri url = Uri.parse(ApiEndPoints.baseUrl +
          ApiEndPoints.authEndpoints.resetPassword +
          '?user_identifier=$userIdentifier&new_password=$newPassword');

      final http.Response response = await http.put(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'user_identifier': userIdentifier,
          'new_password': newPassword,
        }),
      );

      if (response.statusCode == 200) {
        Get.snackbar("Success", "Password Reset Successfully",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.teal,
            colorText: Colors.white);
      } else {
        var responseBody = jsonDecode(response.body);
        var errorMessage = responseBody["message"];
        throw 'Password reset failed:$errorMessage}';
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
