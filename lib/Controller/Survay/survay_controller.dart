import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_tourism/Core/End%20Points/endpoints.dart';
import 'package:smart_tourism/widget/BottomNavigationBar/bottom_navigation_bar.dart';

class SurveySaveController extends GetxController {
  var isLoading = false.obs;
  var selectedTypes = <String>[].obs;

  Future<void> submitSurvey(List<String> selectedTypes) async {
    isLoading.value = true;
    this.selectedTypes.value = selectedTypes;

    // Save to SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('selectedTypes', selectedTypes);

    // Send to server
    final url = ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.survey;
    final body = jsonEncode({
      "category": selectedTypes,
    });

    final response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: body,
    );

    if (response.statusCode == 200) {
      isLoading.value = false;
      Get.snackbar("Success", "Survey submitted successfully");
      print(selectedTypes);
      Get.off(NavBar());
    } else {
      isLoading.value = false;
      Get.snackbar("Error", "Failed to submit survey");
    }
  }

  Future<List<String>> getSelectedTypes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('selectedTypes') ?? [];
  }
}
