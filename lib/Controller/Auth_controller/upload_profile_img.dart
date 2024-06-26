import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_tourism/Controller/Auth_controller/user_information_controller.dart';
import 'package:smart_tourism/Core/End%20Points/endpoints.dart';
import 'package:http_parser/http_parser.dart'; // Add this import statement

class UploadProfilePhotoController extends GetxController {
  var isLoading = false.obs;
  final UserInformation userInformation = Get.find<UserInformation>();

  Future<void> uploadProfileImage(File imageFile) async {
    try {
      isLoading.value = true;

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      if (token == null) {
        throw 'User is not logged in';
      }

      final Uri url = Uri.parse(ApiEndPoints.baseUrl +
          ApiEndPoints.authEndpoints.upload_profile_photo);

      var request = http.MultipartRequest('POST', url)
        ..headers['Authorization'] = 'Bearer $token'
        ..files.add(await http.MultipartFile.fromPath(
          'file',
          imageFile.path,
          contentType:
              MediaType('image', 'jpeg'), // تأكد من تحديد نوع الملف الصحيح هنا
        ));

      var response = await request.send();
      var responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        if (_isValidJson(responseBody)) {
          // تحديث معلومات المستخدم هنا
          userInformation.getUserInfo(); // استدعاء لتحديث معلومات المستخدم
          Get.snackbar("Success", "Profile Image Uploaded Successfully",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.teal,
              colorText: Colors.white);
        } else {
          throw 'Invalid JSON response from server';
        }
      } else {
        if (_isValidJson(responseBody)) {
          var jsonResponse = jsonDecode(responseBody);
          var errorMessage = jsonResponse["message"];
          throw 'Profile image upload failed: $errorMessage';
        } else {
          throw 'Profile image upload failed with status: ${response.statusCode}';
        }
      }
    } catch (error) {
      print(error.toString());
    } finally {
      isLoading.value = false;
    }
  }

  bool _isValidJson(String str) {
    try {
      jsonDecode(str);
      return true;
    } catch (e) {
      return false;
    }
  }
}
