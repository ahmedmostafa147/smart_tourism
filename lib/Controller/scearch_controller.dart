import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:smart_tourism/Core/End%20Points/endpoints.dart';

class SearchControllerFunction extends GetxController {
  final RxBool isLoading = false.obs;
  var country = ''.obs;
  var governorate = ''.obs;
  var category = ''.obs;
  var name = ''.obs;
  Future<void> search({
    required String country,
    required String governorate,
    required String category,
    required String name,
  }) async {
    try {
      isLoading.value = true;

      final Uri url = Uri.parse(ApiEndPoints.baseUrl +
          ApiEndPoints.authEndpoints.search +
          '?country=$country&governorate=$governorate&category=$category&name=$name');

      final Map<String, String?> body = {
        'country': country,
        'governorate': governorate,
        'category': category,
        'name': name,
      };

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data);
      } else {
        throw 'Failed to perform search: ${response.statusCode}';
      }
    } catch (error) {
      print('Error searching: $error');
    } finally {
      isLoading.value = false;
    }
  }
}
