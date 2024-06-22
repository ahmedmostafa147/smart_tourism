import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:smart_tourism/Core/End%20Points/endpoints.dart';
import 'package:smart_tourism/Model/hotel.dart';

class HotelController extends GetxController {
  RxList<Hotel> randomHotels = <Hotel>[].obs;
  var isLoading = false.obs;

  Future<void> fetchRandomHotels(String governorate) async {
    try {
      isLoading.value = true;

      var url = Uri.parse(ApiEndPoints.baseUrl +
          ApiEndPoints.authEndpoints.discover_Hotels +
          '?governorate=' +
          governorate);
      var response = await http.get(url);

      if (response.statusCode == 200) {
        dynamic jsonResponse = jsonDecode(response.body);
        print("Response JSON: $jsonResponse");
        if (jsonResponse is Map<String, dynamic> &&
            jsonResponse['hotels'] is List) {
          randomHotels.value = (jsonResponse['hotels'] as List)
              .map((data) => Hotel.fromJson(data))
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

  Future<void> fetchRandomHotelsHome() async {
    try {
      isLoading.value = true;

      var url = Uri.parse(
          "https://zoz-rwob.onrender.com/discover_hotels/?governorate=Cairo");
      var response = await http.get(url);

      if (response.statusCode == 200) {
        dynamic jsonResponse = jsonDecode(response.body);
        print("Response JSON: $jsonResponse");
        if (jsonResponse is Map<String, dynamic> &&
            jsonResponse['hotels'] is List) {
          randomHotels.value = (jsonResponse['hotels'] as List)
              .map((data) => Hotel.fromJson(data))
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
}
