import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:smart_tourism/Core/End%20Points/endpoints.dart';

class RecommendationBackend {
  final int planNumber;
  final String hotel;
  final double hotelPricePerDay;
  final double totalHotelPrice;
  final double totalPlanPrice;
  final String additionalAmountNeeded;
  final List<PlanRecommendation> planRecommendations;

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
      planRecommendations: (json['plan_recommendations'] as List)
          .map((item) => PlanRecommendation.fromJson(item))
          .toList(),
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
      'plan_recommendations':
          planRecommendations.map((item) => item.toJson()).toList(),
    };
  }
}

class PlanRecommendation {
  final int dayNumber;
  final String recommendationType;
  final String recommendationDescription;
  final int recommendationPrice;

  PlanRecommendation({
    required this.dayNumber,
    required this.recommendationType,
    required this.recommendationDescription,
    required this.recommendationPrice,
  });

  factory PlanRecommendation.fromJson(Map<String, dynamic> json) {
    return PlanRecommendation(
      dayNumber: json['day_number'],
      recommendationType: json['recommendation_type'],
      recommendationDescription: json['recommendation_description'],
      recommendationPrice: json['recommendation_price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'day_number': dayNumber,
      'recommendation_type': recommendationType,
      'recommendation_description': recommendationDescription,
      'recommendation_price': recommendationPrice,
    };
  }
}

class SavedPlansController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxList<RecommendationBackend> savedPlans =
      <RecommendationBackend>[].obs;

  Future<void> fetchSavedPlans() async {
    try {
      isLoading.value = true;
      final url = ApiEndPoints.baseUrl +
          ApiEndPoints.authEndpoints.outputRecommendations;
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      if (token == null) {
        throw 'User is not logged in';
      }

      print((token));

      final response = await http.get(
        Uri.parse(url),
        headers: {
          "Authorization": "Bearer $token",
          'Content-Type': 'application/json'
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);

        List<RecommendationBackend> loadedPlans =
            data.map((plan) => RecommendationBackend.fromJson(plan)).toList();

        savedPlans.assignAll(loadedPlans);

        print(data);
        print(savedPlans);
      } else {
        var responseBody = jsonDecode(response.body);
        var errorMessage = responseBody["message"];
        throw 'Error: $errorMessage';
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch saved plans: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
