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
      } else if (response.statusCode == 400) {
        var responseBody = jsonDecode(response.body);
        var errorDetails = responseBody["detail"] as List;

        // Extracting and formatting the error messages
        var errorMessage = errorDetails.map((error) {
          var loc = (error['loc'] as List).join('.');
          return '${error['msg']} at ${loc}';
        }).join('\n');

        Get.snackbar("Validation Error", errorMessage,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      } else {
        var responseBody = jsonDecode(response.body);
        var errorMessage = responseBody["msg"] ?? 'Unknown error occurred';
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
