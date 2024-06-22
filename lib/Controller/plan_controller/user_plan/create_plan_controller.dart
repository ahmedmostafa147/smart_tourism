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
  final RxBool isValidCountry = false.obs;
  final RxBool isValidGovernorate = false.obs;
  final RxBool isValidnumDays = false.obs;
  final RxBool isValidbudget = false.obs;

  final RxList<String> filteredGovernorates = RxList<String>();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController governorateController = TextEditingController();
  final TextEditingController numDaysController = TextEditingController();
  final TextEditingController budgetController = TextEditingController();
  final TextEditingController planNameController = TextEditingController();
  final TextEditingController restaurantNames = TextEditingController();
  final TextEditingController hotelNames = TextEditingController();
  final TextEditingController placeNames = TextEditingController();
  final List<String> countries = [
    'Egypt',
    "Algeria",
    "Iraq",
    "Jordan",
    "Lebanon",
    "Morocco",
    "Saudi Arabia",
    "Oman",
    "Qatar",
    "Bahrain",
    "Syria",
    "United Arab Emirates",
    "Tunisia"
  ];

  final List<Map<String, dynamic>> governorates = [
    {
      "country": "Egypt",
      "governorates": ["Cairo", "Alexandria", "Giza"]
    },
    {
      "country": "Algeria",
      "governorates": ["Algiers"]
    },
    {
      "country": "Iraq",
      "governorates": ["Baghdad"]
    },
    {
      "country": "Jordan",
      "governorates": ["Amman"]
    },
    {
      "country": "Lebanon",
      "governorates": ["Beirut"]
    },
    {
      "country": "Morocco",
      "governorates": ["Casablanca", "Rabat"]
    },
    {
      "country": "Saudi Arabia",
      "governorates": ["Riyadh"]
    },
    {
      "country": "Oman",
      "governorates": ["Muscat", "Salalah"]
    },
    {
      "country": "Qatar",
      "governorates": ["Doha", "Al Rayyan"]
    },
    {
      "country": "Bahrain",
      "governorates": ["Manama", "Muharraq"]
    },
    {
      "country": "Syria",
      "governorates": ["Damascus", "Aleppo"]
    }
  ];

  final List<String> numDays = ['1', '2', '3', '4', '5', '6', '7'];
  final List<String> budget = ['1000', '2000', '3000', '4000', '5000'];
  void onInit() {
    super.onInit();

    validateFields();
  }

  void showGovernoratesForSelectedCountry(String country) {
    filteredGovernorates.value = getGovernoratesByCountry(country);
    isValidCountry.value = true;
  }

  List<String> getGovernoratesByCountry(String country) {
    final countryData = governorates.firstWhere(
      (element) => element['country'] == country,
      orElse: () => {"country": "", "governorates": []},
    );
    return List<String>.from(countryData['governorates']);
  }

  void validateFields() {
    isValidCountry.value = countries.contains(countryController.text.trim());
    isValidGovernorate.value =
        filteredGovernorates.contains(governorateController.text.trim());
    isValidnumDays.value = numDays.contains(numDaysController.text.trim());
    isValidbudget.value = budget.contains(budgetController.text.trim());
  }

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
      restaurantNames: restaurantNames.text.trim().split(','),
      hotelNames: hotelNames.text.trim().split(','),
      placeNames: placeNames.text.trim().split(','),
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
