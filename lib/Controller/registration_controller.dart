import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:smart_tourism/Core/End%20Points/endpoints.dart';
import 'package:smart_tourism/View/Auth/Login/login.dart';

class RegistrationController extends GetxController {
  TextEditingController first = TextEditingController();
  TextEditingController last = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController location = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final RxBool isLoading = false.obs;

  Future<void> registerWithEmail() async {
    try {
      if (!formKey.currentState!.validate()) {
        return;
      }

      isLoading.value = true;

      var headers = {'Content-Type': 'application/json'};
      var url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.registerEmail);
      Map body = {
        "first_name": first.text,
        "last_name": last.text,
        "user_password": password.text,
        "user_email": email.text.trim(),
        "user_location": location.text
      };

      http.Response response =
          await http.post(url, body: jsonEncode(body), headers: headers);

      if (response.statusCode == 200) {
        Get.snackbar("Success", "Registration Success",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.teal,
            colorText: Colors.white);
        Get.off(() => LoginView());
      
      } else {
        throw jsonDecode(response.body)["Message"];
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}