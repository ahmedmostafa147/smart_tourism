import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:smart_tourism/Core/End%20Points/endpoints.dart';

class SurveySaveController extends GetxController {
  var selectedTypes = <String>[].obs;
  var isLoading = false.obs;
  Future<void> submitSurvey(String category) async {
    isLoading.value = true;
    final url = ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.survey;
    final body = jsonEncode({
      "category": category,
    });

    final response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: body,
    );

    if (response.statusCode == 200) {
      isLoading.value = false;
      Get.snackbar("Success", "Survey submitted successfully");
    } else {
      Get.snackbar("Error", "Failed to submit survey");
    }
  }
}
