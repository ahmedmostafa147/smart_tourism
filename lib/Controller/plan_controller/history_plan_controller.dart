import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_tourism/Controller/plan_controller/model_ai_controller.dart';
import 'package:http/http.dart' as http;
import 'package:smart_tourism/Core/End%20Points/endpoints.dart';

class SavedPlansController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxList<Recommendation> savedPlans = <Recommendation>[].obs;

  Future<void> fetchSavedPlans() async {
    try {
      isLoading.value = true;
      final url = ApiEndPoints.baseUrl +
          ApiEndPoints.authEndpoints.outputRecommendations;
      // Get the authentication token from shared preferences
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      // Make sure token exists
      if (token == null) {
        throw 'User is not logged in';
      }

      final response = await http.get(
        Uri.parse(url),
        headers: {
          "Authorization": "Bearer $token",
          'Content-Type': 'application/json'
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        savedPlans.value = data.map((e) => Recommendation.fromJson(e)).toList();
      } else {
        var responseBody = jsonDecode(response.body);
        var errorMessage = responseBody["message"];
        throw 'Error: $errorMessage';
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch saved plans: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
