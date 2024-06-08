import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:smart_tourism/Controller/plan_controller/create_plan_controller.dart';

class Recommendation {
  final String title;
  final double price;
  final String tags;
  final String governorate;
  final int day;

  Recommendation({
    required this.title,
    required this.price,
    required this.tags,
    required this.governorate,
    required this.day,
  });

  factory Recommendation.fromJson(Map<String, dynamic> json) {
    return Recommendation(
      title: json['Title'],
      price: json['Price'],
      tags: json['Tags'],
      governorate: json['Governorate'],
      day: json['Day'],
    );
  }
}

class ModelAIController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final RxBool isLoading = false.obs;
  final TextEditingController countryController = TextEditingController();
  final TextEditingController governorateController = TextEditingController();
  final TextEditingController numDaysController = TextEditingController();
  final TextEditingController budgetController = TextEditingController();
  final RxList<Recommendation> recommendations = <Recommendation>[].obs;
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

  Future<void> getRecommendations() async {
    try {
      if (!formKey.currentState!.validate()) {
        return;
      }
      isLoading.value = true;
      recommendations.clear();

      final Map<String, dynamic> requestData = {
        "country": countryController.text.trim(),
        "governorate": governorateController.text.trim(),
        "survey_responses": ["Museums"], // Example survey responses
        "num_days": numDaysController.text.trim(),
        "budget": budgetController.text.trim(),
      };
      var url = Uri.parse(
          "https://model-smart-tourism.onrender.com/recommendations/");
      final http.Response response = await http.post(
        url,
        body: jsonEncode(requestData),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        print(data);
        data.forEach((element) {
          recommendations.add(Recommendation.fromJson(element));
        });
        

      } else {
        throw Exception('Failed to load recommendations');
      }
    } catch (e) {
      print('Failed to load recommendations: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
