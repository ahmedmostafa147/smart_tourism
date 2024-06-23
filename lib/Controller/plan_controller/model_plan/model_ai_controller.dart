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
  final double totalPlanPrice;
  final String additionalAmountNeeded;
  final List<String> planRecommendations;

  Recommendation({
    required this.planNumber,
    required this.hotel,
    required this.hotelPricePerDay,
    required this.totalHotelPrice,
    required this.totalPlanPrice,
    required this.additionalAmountNeeded,
    required this.planRecommendations,
  });

  factory Recommendation.fromJson(Map<String, dynamic> json) {
    return Recommendation(
      planNumber: json['plan_number'],
      hotel: json['hotel'],
      hotelPricePerDay: json['hotel_price_per_day'],
      totalHotelPrice: json['total_hotel_price'],
      totalPlanPrice: json['total_plan_price'],
      additionalAmountNeeded: json['additional_amount_needed'],
      planRecommendations: List<String>.from(json['plan_recommendations']),
    );
  }
}

class RecommendationBackend {
  final int planNumber;
  final String hotel;
  final double hotelPricePerDay;
  final double totalHotelPrice;
  final double totalPlanPrice;
  final String additionalAmountNeeded;
  final List<List<String>> planRecommendations;

  RecommendationBackend({
    required this.planNumber,
    required this.hotel,
    required this.hotelPricePerDay,
    required this.totalHotelPrice,
    required this.totalPlanPrice,
    required this.additionalAmountNeeded,
    required this.planRecommendations,
  });

  factory RecommendationBackend.fromJson(Map<String, dynamic> json) {
    return RecommendationBackend(
      planNumber: json['plan_number'],
      hotel: json['hotel'],
      hotelPricePerDay: json['hotel_price_per_day'],
      totalHotelPrice: json['total_hotel_price'],
      totalPlanPrice: json['total_plan_price'],
      additionalAmountNeeded: json['additional_amount_needed'],
      planRecommendations:
          List<List<String>>.from(json[['plan_recommendations']]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'plan_number': planNumber,
      'hotel': hotel,
      'hotel_price_per_day': hotelPricePerDay,
      'total_hotel_price': totalHotelPrice,
      'total_plan_price': totalPlanPrice,
      'additional_amount_needed': additionalAmountNeeded,
      'plan_recommendations': planRecommendations,
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
      "governorates": [
        "Cairo",
        "Giza",
        "Alexandria",
        "Aswan",
        "Luxor",
        "Fayyum",
        "Ismailia",
        "Matrouh",
        "Naama",
        "Red Sea and Sinai",
        "Said",
        "Suez",
      ]
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
  final RxList<String> numPlans = [
    "1",
    "2",
    "3",
    "4",
    "5",
  ].obs;

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
      final String url =
          ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.recommendations;

      // Get the authentication token from shared preferences
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      // Make sure token exists
      if (token == null) {
        throw 'User is not logged in';
      }

      // Create a RecommendationBackend object from the Recommendation object
      final RecommendationBackend recommendationBackend = RecommendationBackend(
        planNumber: recommendation.planNumber,
        hotel: recommendation.hotel,
        hotelPricePerDay: recommendation.hotelPricePerDay,
        totalHotelPrice: recommendation.totalHotelPrice,
        totalPlanPrice: recommendation.totalPlanPrice,
        additionalAmountNeeded: recommendation.additionalAmountNeeded,
        planRecommendations:
            recommendation.planRecommendations.map((rec) => [rec]).toList(),
      );

      // Serialize the RecommendationBackend object to JSON
      final String recommendationJson =
          jsonEncode(recommendationBackend.toJson());

      // Log the data for debugging
      print('Serialized recommendation data: $recommendationJson');

      // Send the HTTP POST request
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Authorization": "Bearer $token",
          'Content-Type': 'application/json',
        },
        body: recommendationJson,
      );

      if (response.statusCode == 200) {
        Get.snackbar("Success", "Recommendation saved successfully",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.teal,
            colorText: Colors.white);
      } else {
        print('Failed to save recommendation: ${response.statusCode}');
        print('Failed to save recommendation: ${response.body}');
        var responseBody = jsonDecode(response.body);
        var errorMessage = responseBody["message"];
        throw 'Error: $errorMessage';
      }
    } catch (e) {
      print('Failed to save recommendation: $e');
      Get.snackbar("Error", "Failed to save recommendation: $e");
    } finally {
      isLoadingSave.value = false;
    }
  }
}
