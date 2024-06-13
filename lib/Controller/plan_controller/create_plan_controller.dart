import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../Core/End%20Points/endpoints.dart';

class Plan {
  int planBudget;
  String planReview;
  int planDuration;
  String destination;
  bool planIsRecommended;
  List<String> restaurantNames;
  List<String> hotelNames;
  List<String> placeNames;

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

  factory Plan.fromJson(Map<String, dynamic> json) {
    return Plan(
      planBudget: json['plan_budget'],
      planReview: json['plan_review'],
      planDuration: json['plan_duration'],
      destination: json['destination'],
      planIsRecommended: json['plan_is_recommended'],
      restaurantNames: List<String>.from(json['restaurant_names']),
      hotelNames: List<String>.from(json['hotel_names']),
      placeNames: List<String>.from(json['place_names']),
    );
  }
}

class PlanController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final RxBool isLoading = false.obs;
  final TextEditingController countryController = TextEditingController();
  final TextEditingController governorateController = TextEditingController();
  final TextEditingController numDaysController = TextEditingController();
  final TextEditingController budgetController = TextEditingController();
  final RxList<Plan> plans = <Plan>[].obs;
  final RxList<String> filteredCountries = RxList<String>();
  final RxList<String> filteredGovernorates = RxList<String>();
  final RxList<String> filterednumDays = RxList<String>();
  final RxList<String> filteredbudget = RxList<String>();
  final List<String> countries = ['Egypt', 'USA', 'France', 'Italy'];
  final List<String> governorates = ['Alexandria', 'Cairo', 'Giza', 'Luxor'];
  final List<String> numDays = ['1', '2', '3', '4', '5'];
  final List<String> budget = ['1000', '2000', '3000', '4000', '5000'];
  void showAllCountries() {
    filteredCountries.value = countries;
  }

  void showAllGovernorates() {
    filteredGovernorates.value = governorates;
  }

  void showAllnumDays() {
    filterednumDays.value = numDays;
  }

  void showAllbudget() {
    filteredbudget.value = budget;
  }

  Future<void> createPlan(Plan newPlan) async {
    try {
      if (!formKey.currentState!.validate()) {
        return;
      }
      isLoading.value = true;
      plans.clear();

      final url = ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.createPlan;
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(newPlan),
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

  Future<void> fetchHistoryPlans() async {
    final url = ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.historyPlans;
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // Handle the response
      // For demonstration, assuming the response is a list of plans
      List<dynamic> data = jsonDecode(response.body);
      // You can map this data to your plan model if necessary
    } else {
      Get.snackbar("Error", "Failed to fetch history plans");
    }
  }
}
