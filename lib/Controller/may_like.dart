import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_tourism/Controller/Survay/survay_controller.dart';

class Recommendation {
  final String title;
  final String country;
  final double price;
  final String tags;
  final String imgLink;

  Recommendation({
    required this.title,
    required this.country,
    required this.price,
    required this.tags,
    required this.imgLink,
  });

  factory Recommendation.fromJson(Map<String, dynamic> json) {
    return Recommendation(
      title: json['Title'] ?? '',
      country: json['Country'] ?? '',
      price: json['Price']?.toDouble() ?? 0.0,
      tags: json['tags'] ?? '',
      imgLink: json['img_link'] ?? '',
    );
  }
}

class MayLikedController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxList<Recommendation> mayLikedItems = <Recommendation>[].obs;
  SurveySaveController surveySaveController = Get.put(SurveySaveController());

  @override
  void onInit() {
    super.onInit();
    fetchMayLikedItems();
  }

  Future<void> fetchMayLikedItems() async {
    try {
      isLoading.value = true;

      // Get the authentication token from shared preferences
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      // Make sure token exists
      if (token == null) {
        throw 'User is not logged in';
      }

      // Ensure survey results are not null and contain valid values
      await surveySaveController.fetchSurveyResults();

      // Prepare the data for the POST request
      final requestData = {
        "tags": surveySaveController.surveyResults,
      };

      

      // Send the request to fetch may liked items with the authentication token in the headers
      final Uri url =
          Uri.parse("https://may-like.onrender.com/recommendations/");
      final http.Response response = await http.post(
        url,
        headers: <String, String>{
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestData),
      );

      // Check the response status code
      if (response.statusCode == 200) {
        isLoading.value = false;
        response.body;
    
        final List<dynamic> data = jsonDecode(response.body)['recommendations'];
        mayLikedItems.value =
            data.map((item) => Recommendation.fromJson(item)).toList();

      } else {
        throw 'Invalid data format: Missing or invalid "recommendations" field';
      }
    } catch (error) {
      print('Failed to fetch may liked items: $error');
      Get.snackbar("Error", error.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }
}
