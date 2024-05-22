import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../Core/End%20Points/endpoints.dart';

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
          navigateAfterLogin();
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
      Get.snackbar("Error", error.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> navigateAfterLogin() async {
    final SharedPreferences prefs = await _prefs;
    final String? location = prefs.getString('location');
    final List<String>? survey = prefs.getStringList('survey');

    if (location == null) {
      // Location not saved, navigate to location screen
      Get.offNamed('/location');
    } else if (survey == null || survey.isEmpty) {
      // Survey not saved, navigate to survey screen
      Get.offNamed('/survey');
    } else {
      // Both location and survey are saved, navigate to home screen
      Get.offNamed('/bottomNavBar');
    }
  }
}
