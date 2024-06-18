import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:smart_tourism/Controller/Survay/survay_controller.dart';
import 'package:smart_tourism/Core/End%20Points/endpoints.dart';

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

  Map<String, dynamic> toJson() {
    return {
      'Title': title,
      'Price': price,
      'Tags': tags,
      'Governorate': governorate,
      'Day': day,
    };
  }
}

class ModelAIController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final RxBool isLoading = false.obs;
  final RxBool isValidCountry = false.obs;
  final RxBool isValidGovernorate = false.obs;
  final RxBool isValidnumDays = false.obs;
  final RxBool isValidbudget = false.obs;
  final TextEditingController countryController = TextEditingController();
  final TextEditingController governorateController = TextEditingController();
  final TextEditingController numDaysController = TextEditingController();
  final TextEditingController budgetController = TextEditingController();
  final RxList<Recommendation> recommendations = <Recommendation>[].obs;
  final RxList<String> filteredGovernorates = RxList<String>();
  final RxBool attemptedValidation = false.obs;

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
      "governorates": [
        "Cairo",
        "Alexandria",
        "Giza",
      ],
    },
    // Add other countries and their governorates here
  ];

  final List<String> numDays = ['1', '2', '3', '4', '5', '6', '7'];
  final List<String> budget = ['1000', '2000', '3000', '4000', '5000'];
  SurveySaveController surveySaveController = Get.put(SurveySaveController());

  @override
  void onInit() {
    super.onInit();
    loadSurveyResults();
  }

  Future<void> loadSurveyResults() async {
    await surveySaveController.fetchSurveyResults();
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

  Future<void> getRecommendations() async {
    try {
      if (!formKey.currentState!.validate()) {
        return;
      }

      if (!isValidCountry.value ||
          !isValidGovernorate.value ||
          !isValidnumDays.value ||
          !isValidbudget.value) {
        return;
      }

      isLoading.value = true;
      recommendations.clear();

      final Map<String, dynamic> requestData = {
        "country": countryController.text.trim(),
        "governorate": governorateController.text.trim(),
        "survey_responses": surveySaveController.surveyResults,
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

  Future<void> saveRecommendation(Recommendation recommendation) async {
    final RxBool isLoadingSave = false.obs;
    try {
      isLoadingSave.value = true;
      final url =
          ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.recommendations;
      // Get the authentication token from shared preferences
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      // Make sure token exists
      if (token == null) {
        throw 'User is not logged in';
      }

      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Authorization": "Bearer $token",
          'Content-Type': 'application/json',
        },
        body: jsonEncode(recommendation.toJson()),
      );

      if (response.statusCode == 200) {
        Get.snackbar("Success", "Recommendation saved successfully");
      } else {
        var responseBody = jsonDecode(response.body);
        var errorMessage = responseBody["message"];
        throw 'Error: $errorMessage';
      }
    } catch (e) {
      print('Failed to save recommendation: $e');
      Get.snackbar("Error", "Failed to save recommendation: $e");
    }
  }
}
