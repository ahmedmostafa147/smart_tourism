import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:smart_tourism/Core/End%20Points/endpoints.dart';
import 'package:smart_tourism/Model/place.dart';

class PlaceController extends GetxController {
  RxList<Place> randomPlaces = <Place>[].obs;
  var isLoading = false.obs;

  Future<void> fetchRandomPlaces(String governorate) async {
    try {
      isLoading.value = true;

      final Uri url = Uri.parse(ApiEndPoints.baseUrl +
          ApiEndPoints.authEndpoints.discover_places +
          '?governorate=' +
          governorate);

      var response = await http.get(url);

      if (response.statusCode == 200) {
        dynamic jsonResponse = jsonDecode(response.body);
        print("Response JSON: $jsonResponse");
        if (jsonResponse is Map<String, dynamic> &&
            jsonResponse['places'] is List) {
          randomPlaces.value = (jsonResponse['places'] as List)
              .map((data) => Place.fromJson(data))
              .toList();
        }
      } else {
        throw 'Error: ${response.statusCode}, Message: ${response.body}';
      }
    } catch (error) {
      print(error.toString());
      Get.snackbar(
        "Error",
        error.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        duration: Duration(seconds: 5),
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchRandomPlacesHome() async {
    try {
      isLoading.value = true;

      final Uri url = Uri.parse(
        "https://zoz-rwob.onrender.com/discover_places/?governorate=cairo",
      );

      var response = await http.get(url);

      if (response.statusCode == 200) {
        dynamic jsonResponse = jsonDecode(response.body);
       
        if (jsonResponse is Map<String, dynamic> &&
            jsonResponse['places'] is List) {
          randomPlaces.value = (jsonResponse['places'] as List)
              .map((data) => Place.fromJson(data))
              .toList();
        }
      } else {
        throw 'Error: ${response.statusCode}, Message: ${response.body}';
      }
    } catch (error) {
      print(error.toString());
      Get.snackbar(
        "Error",
        error.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        duration: Duration(seconds: 5),
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
