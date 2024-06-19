import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:smart_tourism/Model/place.dart';

class PlaceController extends GetxController {
  RxList<Place> randomPlaces = <Place>[].obs;
  var isLoading = false.obs;

  Future<void> fetchRandomPlaces(String country) async {
    var headers = {'Content-Type': 'application/json'};
    try {
      isLoading.value = true;

      var url = Uri.parse('YOUR_API_ENDPOINT_HERE'); // Update with the correct endpoint
      var response = await http.post(
        url,
        body: jsonEncode({'country': country}),
        headers: headers,
      );

      if (response.statusCode == 200) {
        dynamic jsonResponse = jsonDecode(response.body);
        if (jsonResponse is Map<String, dynamic> && jsonResponse['random_places'] is List) {
          randomPlaces.value = (jsonResponse['random_places'] as List)
              .map((data) => Place.fromJson(data))
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
