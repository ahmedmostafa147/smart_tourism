import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_tourism/Core/End%20Points/endpoints.dart';
import 'package:http/http.dart' as http;

class PhotoController extends GetxController {
  var isLoading = false.obs;
  var profileImage = ''.obs;

  Future<void> GetProfileImage(String imageUrl) async {
    try {
      isLoading.value = true;
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      final String? token = prefs.getString('token');

      if (token == null) {
        throw 'User is not logged in';
      }

      // Remove leading slash if present
      final correctedImageUrl =
          imageUrl.startsWith('/') ? imageUrl.substring(1) : imageUrl;

      final Uri url = Uri.parse(ApiEndPoints.baseUrl + correctedImageUrl);

      final http.Response response =
          await http.get(url, headers: {'Authorization': 'Bearer $token'});
      if (response.statusCode == 200) {
        profileImage.value = url.toString();
      } else {
        var responseBody = jsonDecode(response.body);
        var errorMessage = responseBody["message"];
        throw 'Failed to get user information: $errorMessage';
      }
    } catch (error) {
    } finally {
      isLoading.value = false;
    }
  }
}
