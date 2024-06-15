import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_tourism/Core/End%20Points/endpoints.dart';

class Plan {
  final int planBudget;
  final String planReview;
  final int planDuration;
  final String destination;
  final bool planIsRecommended;
  final List<String> restaurantNames;
  final List<String> hotelNames;
  final List<String> placeNames;

  Plan({
    required this.planBudget,
    required this.planReview,
    required this.planDuration,
    required this.destination,
    required this.planIsRecommended,
    required this.restaurantNames,
    required this.hotelNames,
    required this.placeNames,
  });

  Map<String, dynamic> toJson() {
    return {
      'plan_budget': planBudget,
      'plan_review': planReview,
      'plan_duration': planDuration,
      'destination': destination,
      'plan_is_recommended': planIsRecommended,
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
  final TextEditingController governorateController = TextEditingController();
  final TextEditingController numDaysController = TextEditingController();
  final TextEditingController budgetController = TextEditingController();

  final List<String> countries = ['Egypt', 'USA', 'France', 'Italy'];
  final List<String> governorates = ['Alexandria', 'Cairo', 'Giza', 'Luxor'];
  final List<String> numDays = ['1', '2', '3', '4', '5'];
  final List<String> budget = ['1000', '2000', '3000', '4000', '5000'];

  Future<void> createPlan() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    final newPlan = Plan(
      planBudget: int.parse(budgetController.text.trim()),
      planReview: '', // يمكن تحديثه عند الحاجة
      planDuration: int.parse(numDaysController.text.trim()),
      destination: countryController.text.trim(),
      planIsRecommended: false,
      restaurantNames: [], // يمكن تحديثه عند الحاجة
      hotelNames: [], // يمكن تحديثه عند الحاجة
      placeNames: [], // يمكن تحديثه عند الحاجة
    );

    try {
      isLoading.value = true;
      final url = ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.createPlan;
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(newPlan.toJson()),
      );

      if (response.statusCode == 200) {
        Get.snackbar("Success", "Plan created successfully");
      } else {
        Get.snackbar("Error", "Failed to create plan");
      }
    } finally {
      isLoading.value = false;
    }
  }
}
