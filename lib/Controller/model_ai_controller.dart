import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:smart_tourism/Core/End%20Points/endpoints.dart';
import 'dart:convert';
import 'package:smart_tourism/Model/model_get_recommendation.dart';

class ModelAIController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final RxBool isLoading = false.obs;

  final RxList<Recommendation> recommendations = <Recommendation>[].obs;

  Future<void> getRecommendations() async {
    try {
      if (!formKey.currentState!.validate()) {
        return;
      }
      isLoading.value = true;
      recommendations.clear();

      final Map<String, dynamic> requestData = {
        "country": "Egypt",
        "governorate": "Alexandria",
        "survey_responses": ["Museums"],
        "num_days": 5,
        "budget": 10000
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
}
