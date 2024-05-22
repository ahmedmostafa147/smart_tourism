import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../Core/End%20Points/endpoints.dart';

class DeleteAccController extends GetxController {
  final RxBool isLoading = false.obs;

  Future<void> deleteUserAccount() async {
    try {
      isLoading.value = true;
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');
      // Make sure token exists
      if (token == null) {
        throw 'User is not logged in';
      }

      // Send the delete account request with the authentication token in the headers
      final Uri url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.deleteEmail);
      final http.Response response = await http.delete(
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

        Get.snackbar("Success", "Account Deleted Successfully",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.teal,
            colorText: Colors.white);

        // Navigate to login screen
        Get.offNamed('/login');
      } else {
        throw 'Account deletion failed: ${response.statusCode}';
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
