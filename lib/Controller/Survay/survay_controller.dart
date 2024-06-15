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

    // Get the token from SharedPreferences
    String? token = prefs.getString('token');

    if (token == null || token.isEmpty) {
      isLoading.value = false;
      Get.snackbar("Error", "Authentication token is missing");
      return;
    }

    // Send to server
    final url = ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.survey;
    final body = jsonEncode({
      "category": selectedTypes,
    });

    try {
      final response = await _postWithRedirect(Uri.parse(url), body, token);

      if (response.statusCode == 200) {
        Get.snackbar("Success", "Survey submitted successfully");
        Get.off(NavBar());
      } else {
        Get.snackbar(
            "Error", "Failed to submit survey: ${response.reasonPhrase}");
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to submit survey: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<http.Response> _postWithRedirect(
      Uri url, String body, String token) async {
    final client = http.Client();
    http.Response response = await client.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: body,
    );

    int redirectCount = 0;
    while (response.isRedirect && redirectCount < 5) {
      final newUrl = response.headers['location'];
      if (newUrl != null) {
        response = await client.post(
          Uri.parse(newUrl),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          },
          body: body,
        );
        redirectCount++;
      } else {
        break;
      }
    }
    return response;
  }

  Future<List<String>> getSelectedTypes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('selectedTypes') ?? [];
  }
}
