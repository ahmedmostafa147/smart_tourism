import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_tourism/Core/End%20Points/endpoints.dart';
import 'package:smart_tourism/widget/BottomNavigationBar/bottom_navigation_bar.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final RxBool isLoading = false.obs;

  Future<void> loginWithEmail() async {
    var headers = {'Content-Type': 'application/json'};
    try {
      if (!formKey.currentState!.validate()) {
        return;
      }
      isLoading.value = true;
      var url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.loginEmail);
      Map body = {
        'user_email': emailController.text.trim(),
        'user_password': passwordController.text
      };
      http.Response response =
          await http.post(url, body: jsonEncode(body), headers: headers);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        var token = json['access_token'];
        if (token != null) {
          final SharedPreferences? prefs = await _prefs;
          await prefs?.setString('token', token);
          print('Token: $token');
          Get.off(BottomNavBar());
          Get.snackbar("Success", "Login Success",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.teal,
              colorText: Colors.white);
        } else {
          throw 'Access token not found in response';
        }
      } else {
        throw 'Error: ${response.statusCode}, Message: ${response.body}';
      }
    } catch (error) {
      Get.snackbar("Error", _parseErrorMessage(error),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  String _parseErrorMessage(dynamic error) {
    if (error is String) {
      return error;
    } else if (error is http.Response) {
      try {
        final Map<String, dynamic> responseData = jsonDecode(error.body);
        return responseData['message'] ?? 'An unknown error occurred';
      } catch (_) {
        return 'An unknown error occurred';
      }
    } else {
      return 'An unknown error occurred';
    }
  }
}
