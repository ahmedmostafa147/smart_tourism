import 'dart:convert';
import 'package:get/get.dart';
import '../../Core/End%20Points/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ResetPasswordController extends GetxController {
  final RxBool isLoading = false.obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController Email = TextEditingController();
  TextEditingController NewPassword = TextEditingController();
  final RxString emailError = ''.obs;
  final RxString passwordError = ''.obs;

  @override
  void onInit() {
    super.onInit();
    Email.addListener(() => validateEmail(Email.text));
    NewPassword.addListener(() => validatePassword(NewPassword.text));
  }

  @override
  void onClose() {
    Email.dispose();
    NewPassword.dispose();
    super.onClose();
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      passwordError.value = 'Password is required';
    } else if (value.length < 8) {
      passwordError.value = 'Password must be at least 8 characters long';
    } else if (!RegExp(r'[A-Z]').hasMatch(value)) {
      passwordError.value =
          'Password must contain at least 1 uppercase letter(A-Z)';
    } else if (!RegExp(r'[a-z]').hasMatch(value)) {
      passwordError.value =
          'Password must contain at least 1 lowercase letter(a-z)';
    } else if (!RegExp(r'[0-9]').hasMatch(value)) {
      passwordError.value = 'Password must contain at least 1 number(0-9)';
    } else if (!RegExp(r'[!@#\$&*~]').hasMatch(value)) {
      passwordError.value =
          'Password must contain at least 1 special character(!@#\$&*~)';
    } else if (value.length > 64) {
      passwordError.value = 'Password must be at most 64 characters long';
    } else {
      passwordError.value = '';
    }
    return passwordError.value.isEmpty ? null : passwordError.value;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      emailError.value = 'Email is required';
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      emailError.value = 'Invalid email format';
    } else {
      emailError.value = '';
    }
    return emailError.value.isEmpty ? null : emailError.value;
  }

  Future<void> resetPassword(String userIdentifier, String newPassword) async {
    if (!formKey.currentState!.validate()) {
      return;
    }
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
        Get.snackbar("Error", errorMessage,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
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
