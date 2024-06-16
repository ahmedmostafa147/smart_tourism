import 'dart:convert';

import 'package:get/get.dart';
import 'package:smart_tourism/Controller/plan_controller/model_ai_controller.dart';
import 'package:http/http.dart' as http;

class SavedPlansController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxList<Recommendation> savedPlans = <Recommendation>[].obs;

  Future<void> fetchSavedPlans() async {
    try {
      isLoading.value = true;
      final url = Uri.parse('YOUR_API_ENDPOINT_FOR_FETCHING_SAVED_PLANS');
      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        savedPlans.value = data.map((e) => Recommendation.fromJson(e)).toList();
      } else {
        throw Exception('Failed to fetch saved plans');
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch saved plans: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
