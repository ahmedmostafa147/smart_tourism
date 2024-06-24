import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_tourism/Core/End%20Points/endpoints.dart';
import 'package:http/http.dart' as http;

class UserHistoryPlans extends GetxController {
  var isLoading = false.obs;
  var userHistoryPlans = <Map<String, dynamic>>[].obs; // List of maps

  Future<void> fetchUserHistoryPlan() async {
    final url = ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.historyPlans;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    
    if (token == null) {
      Get.snackbar("Error", "User is not logged in");
      return;
    }

    isLoading.value = true; // Start loading

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
      );

      print("Response Status: ${response.statusCode}");
      print("Response Body: ${response.body}");
      
      if (response.statusCode == 200) {
        // Assuming the response body is a simple string message
        final String responseBody = response.body;
        
        // If the response body is a JSON string, decode it
        try {
          final decodedResponse = json.decode(responseBody);
          if (decodedResponse is List) {
            userHistoryPlans.value = List<Map<String, dynamic>>.from(decodedResponse);
          } else {
            userHistoryPlans.value = [];
          }
        } catch (e) {
          print("Decoding error: $e");
          userHistoryPlans.value = [];
        }
        
        print("User History Plans: $userHistoryPlans");
      } else {
        Get.snackbar("Error", "Failed to fetch Plans: ${response.body}");
      }
    } catch (e) {
      print("Error occurred: $e");
      Get.snackbar("Error", "An error occurred while fetching Plans");
    } finally {
      isLoading.value = false; // Stop loading
    }
  }
}
