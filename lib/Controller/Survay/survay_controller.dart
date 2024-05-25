import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SurveyController extends GetxController {
  Future<void> submitSurvey(String category) async {
    final url = 'https://yourapi.com/survey';
    final body = jsonEncode({
      "category": category,
    });

    final response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: body,
    );

    if (response.statusCode == 200) {
      Get.snackbar("Success", "Survey submitted successfully");
    } else {
      Get.snackbar("Error", "Failed to submit survey");
    }
  }
}
