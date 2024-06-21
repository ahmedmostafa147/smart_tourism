import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../Core/End Points/endpoints.dart';

class UserInformation extends GetxController {
  final RxMap<String, dynamic> userInfo = <String, dynamic>{}.obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getUserInfo();
  }

  Future<void> getUserInfo() async {
    try {
      isLoading.value = true;
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');
      if (token == null) throw 'User is not logged in';
      final Uri url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.getProfile);
      final http.Response response =
          await http.get(url, headers: {'Authorization': 'Bearer $token'});
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        userInfo.assignAll(responseData);
        print(userInfo);
      } else {
        var responseBody = jsonDecode(response.body);
        var errorMessage = responseBody["message"];
        throw 'Failed to get user information: ${errorMessage}';
      }
    } catch (error) {
      Get.snackbar('Error', error.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }
}

class UserInformationRow extends GetxController {
  final RxMap<String, dynamic> userInfo = <String, dynamic>{}.obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getUserInfoRow();
  }

  Future<void> getUserInfoRow() async {
    try {
      isLoading.value = true;
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');
      if (token == null) throw 'User is not logged in';
      final Uri url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.getProfile);
      final http.Response response =
          await http.get(url, headers: {'Authorization': 'Bearer $token'});
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        userInfo.assignAll(responseData);
      } else {
        var responseBody = jsonDecode(response.body);
        var errorMessage = responseBody["message"];
        throw 'Failed to get user information: ${errorMessage}';
      }
    } catch (error) {
      Get.snackbar('Error', error.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }
}
