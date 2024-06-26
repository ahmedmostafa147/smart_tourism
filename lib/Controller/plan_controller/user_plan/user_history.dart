import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_tourism/Core/End%20Points/endpoints.dart';
import 'package:http/http.dart' as http;

class Plan {
  final int planBudget;
  final int planDuration;
  final String destination;
  final List<String> restaurantNames;
  final List<String> hotelNames;
  final List<String> placeNames;

  Plan({
    required this.planBudget,
    required this.planDuration,
    required this.destination,
    required this.restaurantNames,
    required this.hotelNames,
    required this.placeNames,
  });

  factory Plan.fromJson(Map<String, dynamic> json) {
    return Plan(
      planBudget: json['plan_budget'],
      planDuration: json['plan_duration'],
      destination: json['destination'],
      restaurantNames: List<String>.from(json['restaurant_names']),
      hotelNames: List<String>.from(json['hotel_names']),
      placeNames: List<String>.from(json['place_names']),
    );
  }
}

class UserHistoryPlans extends GetxController {
  var isLoading = false.obs;
  var userHistoryPlans = <Plan>[].obs;

  Future<void> fetchUserHistoryPlan() async {
    final url = ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.historyPlans;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    if (token == null) {
      Get.snackbar("Error", "User is not logged in");
      return;
    }

    try {
      isLoading.value = true;
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
        final List<dynamic> data = jsonDecode(response.body);
        userHistoryPlans.value =
            data.map((json) => Plan.fromJson(json)).toList();
      } else {
        Get.snackbar("Error", "Failed to fetch user history plans");
      }
    } catch (e) {
      print("Error occurred: $e");
      Get.snackbar("Error", "An error occurred while fetching plans");
    } finally {
      isLoading.value = false;
    }
  }
}
