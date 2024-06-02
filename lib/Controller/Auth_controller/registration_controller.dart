import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../location_controller.dart';
import '../../Core/End%20Points/endpoints.dart';
import '../../View/Auth/Login/login.dart';

class RegistrationController extends GetxController {
  LocationController locationController = Get.put(LocationController());
  TextEditingController first = TextEditingController();
  TextEditingController last = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController location = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final RxBool isLoading = false.obs;
  final RxString firstNameError = ''.obs;
  final RxString lastNameError = ''.obs;
  final RxString emailError = ''.obs;
  final RxString passwordError = ''.obs;

  String? validateFirstName(String? value) {
    if (value == null || value.isEmpty) {
      firstNameError.value = 'First name is required';
    } else if (value.length < 3) {
      firstNameError.value = 'First name must be at least 3 characters long';
    } else if (!RegExp(r'[a-zA-Z]').hasMatch(value)) {
      firstNameError.value = 'First name must contain only alphabets';
    } else {
      firstNameError.value = '';
    }
    return firstNameError.value.isEmpty ? null : firstNameError.value;
  }

  String? validateLastName(String? value) {
    if (value == null || value.isEmpty) {
      lastNameError.value = 'Last name is required';
    } else if (value.length < 3) {
      lastNameError.value = 'Last name must be at least 3 characters long';
    } else if (!RegExp(r'[a-zA-Z]').hasMatch(value)) {
      lastNameError.value = 'Last name must contain only alphabets';
    } else {
      lastNameError.value = '';
    }
    return lastNameError.value.isEmpty ? null : lastNameError.value;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      passwordError.value = 'Password is required';
    } else if (!RegExp(
            r'^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#\$&*~]).{8,64}$')
        .hasMatch(value)) {
      passwordError.value = 'Password must contain at least:\n'
          '- 8 to 64 characters\n'
          '- 1 uppercase letter\n'
          '- 1 lowercase letter\n'
          '- 1 number\n'
          '- 1 special character';
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
        "user_location": locationController.addressCountry.value,
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
        var responseBody = jsonDecode(response.body);
        var errorMessage = responseBody["detail"];
        Get.snackbar("Error", errorMessage,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }
    } catch (e) {
      print(e.toString());
      Get.snackbar("Error", "An error occurred: $e",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }
}
