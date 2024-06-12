import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SurveyGetController extends GetxController {
  var surveyResult = {}.obs;

  Future<void> getSurvey(String category) async {
    final url = 'https://yourapi.com/survey';
    final response = await http.get(
      Uri.parse('$url?category=$category'),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      surveyResult.value = jsonDecode(response.body);
      Get.snackbar("Success", "Survey results fetched successfully");
    } else {
      Get.snackbar("Error", "Failed to fetch survey results");
    }
  }
}
