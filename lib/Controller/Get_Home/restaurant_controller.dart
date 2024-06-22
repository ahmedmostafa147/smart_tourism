import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:smart_tourism/Core/End%20Points/endpoints.dart';
import 'package:smart_tourism/Model/restaurant.dart';

class RestaurantController extends GetxController {
  RxList<Restaurant> randomRestaurants = <Restaurant>[].obs;
  var isLoading = false.obs;

  Future<void> fetchRandomRestaurants(String country) async {
    try {
      isLoading.value = true;
      final Uri url = Uri.parse(ApiEndPoints.baseUrl +
          ApiEndPoints.authEndpoints.discover_Restaurants +
          '?country=' +
          country);

      var response = await http.get(url);

      if (response.statusCode == 200) {
        dynamic jsonResponse = jsonDecode(response.body);
        print("Response JSON: $jsonResponse");
        if (jsonResponse is Map<String, dynamic> &&
            jsonResponse['restaurants'] is List) {
          randomRestaurants.value = (jsonResponse['restaurants'] as List)
              .map((data) => Restaurant.fromJson(data))
              .toList();
        }
      } else {
        throw 'Error: ${response.statusCode}, Message: ${response.body}';
      }
    } catch (error) {
      print(error.toString());
      Get.snackbar("Error", error.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          duration: Duration(seconds: 5),
          colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchRandomRestaurantsHome() async {
    try {
      isLoading.value = true;
      final Uri url = Uri.parse(
          "https://zoz-rwob.onrender.com/discover_restaurants/?governorate=Cairo");

      var response = await http.get(url);

      if (response.statusCode == 200) {
        dynamic jsonResponse = jsonDecode(response.body);
        print("Response JSON: $jsonResponse");
        if (jsonResponse is Map<String, dynamic> &&
            jsonResponse['restaurants'] is List) {
          randomRestaurants.value = (jsonResponse['restaurants'] as List)
              .map((data) => Restaurant.fromJson(data))
              .toList();
        } else {
          throw 'Unexpected response format';
        }
      } else {
        throw 'Error: ${response.statusCode}, Message: ${response.body}';
      }
    } catch (error) {
      print(error.toString());
      Get.snackbar("Error", error.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          duration: Duration(seconds: 5),
          colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }
}
