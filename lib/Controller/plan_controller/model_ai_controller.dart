import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:smart_tourism/Controller/Survay/survay_controller.dart';
import 'package:smart_tourism/Core/End%20Points/endpoints.dart';

class Recommendation {
  final int planNumber;
  final String hotel;
  final double hotelPricePerDay;
  final double totalHotelPrice;
  final List<String> planRecommendations;
  final double totalPlanPrice;
  final String additionalAmountNeeded;

  Recommendation({
    required this.planNumber,
    required this.hotel,
    required this.hotelPricePerDay,
    required this.totalHotelPrice,
    required this.planRecommendations,
    required this.totalPlanPrice,
    required this.additionalAmountNeeded,
  });

  factory Recommendation.fromJson(Map<String, dynamic> json) {
    return Recommendation(
      planNumber: json['plan_number'],
      hotel: json['hotel'],
      hotelPricePerDay: json['hotel_price_per_day'],
      totalHotelPrice: json['total_hotel_price'],
      planRecommendations: List<String>.from(json['plan_recommendations']),
      totalPlanPrice: json['total_plan_price'],
      additionalAmountNeeded: json['additional_amount_needed'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'plan_number': planNumber,
      'hotel': hotel,
      'hotel_price_per_day': hotelPricePerDay,
      'total_hotel_price': totalHotelPrice,
      'plan_recommendations': planRecommendations,
      'total_plan_price': totalPlanPrice,
      'additional_amount_needed': additionalAmountNeeded,
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
  final RxBool isValidnum_plans = false.obs;
  final RxList<String> numPlans = [
    "1",
    "2",
    "3",
    "4",
    "5",
  ].obs;
  final TextEditingController countryController = TextEditingController();
  final TextEditingController governorateController = TextEditingController();
  final TextEditingController numDaysController = TextEditingController();
  final TextEditingController budgetController = TextEditingController();
  final TextEditingController num_plansController = TextEditingController();
  final RxList<Recommendation> recommendations = <Recommendation>[].obs;
  final RxList<String> filteredGovernorates = RxList<String>();

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
  final List<String> budget = [
    '500',
    '1000',
    '1500',
    '2000',
    '2500',
    '3000',
  ];

  SurveySaveController surveySaveController = Get.put(SurveySaveController());

  @override
  void onInit() {
    super.onInit();
    loadSurveyResults();
    validateFields();
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

  void validateFields() {
    isValidCountry.value = countries.contains(countryController.text.trim());
    isValidGovernorate.value =
        filteredGovernorates.contains(governorateController.text.trim());
    isValidnumDays.value = numDays.contains(numDaysController.text.trim());
    isValidbudget.value = budget.contains(budgetController.text.trim());
    isValidnum_plans.value = numPlans.contains(num_plansController.text.trim());
  }

  Future<void> getRecommendations() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;
    recommendations.clear();

    final Map<String, dynamic> requestData = {
      "country": countryController.text.trim(),
      "governorates": [governorateController.text.trim()], // Change this line
      "survey_responses": surveySaveController.surveyResults,
      "num_days": numDaysController.text.trim(),
      "budget": budgetController.text.trim(),
      "num_plans": num_plansController.text.trim()
    };

    try {
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
        print('Failed to load recommendations: ${response.statusCode}');
        print('Failed to load recommendations: ${response.body}');

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
