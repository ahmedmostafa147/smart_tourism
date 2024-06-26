import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_tourism/Core/End%20Points/endpoints.dart';

class Plan {
  final int planBudget;
  final int planDuration;
  final String destination;
  List<String>? restaurantNames;
  List<String>? hotelNames;
  List<String>? placeNames;

  Plan({
    required this.planBudget,
    required this.planDuration,
    required this.destination,
    this.restaurantNames,
    this.hotelNames,
    this.placeNames,
  });

  Map<String, dynamic> toJson() {
    return {
      'plan_budget': planBudget,
      'plan_duration': planDuration,
      'destination': destination,
      'restaurant_names': restaurantNames,
      'hotel_names': hotelNames,
      'place_names': placeNames,
    };
  }
}

class PlanController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final RxBool isLoading = false.obs;
  final TextEditingController countryController = TextEditingController();
  final TextEditingController budgetController = TextEditingController();
  final TextEditingController numDaysController = TextEditingController();
  final TextEditingController planNameController = TextEditingController();
  final TextEditingController restaurantNames = TextEditingController();
  final TextEditingController hotelNames = TextEditingController();
  final TextEditingController placeNames = TextEditingController();

  Future<void> createPlan() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    final newPlan = Plan(
      planBudget: int.parse(budgetController.text.trim()),
      planDuration: int.parse(numDaysController.text.trim()),
      destination: countryController.text.trim(),
      restaurantNames: restaurantNames.text.trim().split(','),
      hotelNames: hotelNames.text.trim().split(','),
      placeNames: placeNames.text.trim().split(','),
    );

    // Get the authentication token from shared preferences
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    // Make sure token exists
    if (token == null) {
      throw 'User is not logged in';
    }

    try {
      isLoading.value = true;
      final url = ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.createPlan;
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
        body: jsonEncode(newPlan.toJson()),
      );

      if (response.statusCode == 200) {
        Get.snackbar("Success", "Plan created successfully");
      } else {
        print('Failed to Create : ${response.statusCode}');
        print('Failed to Create: ${response.body}');
        var responseBody = jsonDecode(response.body);
        var errorMessage = responseBody["message"];
        throw 'Error: $errorMessage';
      }
    } finally {
      isLoading.value = false;
    }
  }
}
