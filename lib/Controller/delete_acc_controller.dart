import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_tourism/Core/End%20Points/endpoints.dart';

class DeleteAccController extends GetxController {
  final RxBool isLoading = false.obs;

  Future<void> deleteAccount(int userId) async {
    try {
       isLoading.value = true;
      
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

     
      if (token == null) {
        throw 'User is not logged in';
      }

      final Uri url = Uri.parse(ApiEndPoints.baseUrl +
          ApiEndPoints.authEndpoints.deleteEmail +
          '?user_id=$userId');

     
      final http.Response response = await http.delete(
        url,
        headers: <String, String>{
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

     
      if (response.statusCode == 200) {
        Get.snackbar("Success", "Delete Email Success",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.teal,
            colorText: Colors.white);
        Get.offAllNamed('/login');
      } else {
        Get.snackbar("Field", "Delete Email Failed",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);

        throw 'Account deletion failed: ${response.statusCode}';
      }
    } catch (error) {
       Get.snackbar("Error", "Failed to delete account: $error",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
     finally {
      // Hide loading indicator
      isLoading.value = false;
    }
  }
}
