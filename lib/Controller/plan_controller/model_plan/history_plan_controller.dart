import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
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
  String _cleanText(String input) {
    return input.replaceAll(
        RegExp(r'[^\x00-\x7F]'), ''); // Remove non-ASCII characters
  }
}

class SavedPlansController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxList<Recommendation> savedPlans = <Recommendation>[].obs;

  Future<void> fetchSavedPlans() async {
    final url =
        ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.outputRecommendations;
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
          "Authorization": "Bearer $token",
          'Content-Type': 'application/json'
        },
      );

      if (response.statusCode == 200) {
        print(response.body);
        List<dynamic> data = jsonDecode(response.body);

        List<Recommendation> loadedPlans =
            data.map((plan) => Recommendation.fromJson(plan)).toList();

        savedPlans.assignAll(loadedPlans);

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
