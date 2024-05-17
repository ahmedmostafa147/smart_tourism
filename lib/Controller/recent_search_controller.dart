import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_tourism/Core/End%20Points/endpoints.dart';

class RecentSearchesController extends GetxController {
  late SharedPreferences prefs;
  var recentSearches = <String>[].obs;
  var isLoading = false.obs;

  Future<void> fetchRecentSearches() async {
    isLoading.value = true;
    try {
      prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token != null) {
        var apiUrl =
            ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.recentSearches;
        var response = await http.get(Uri.parse(apiUrl), headers: {
          'Authorization': 'Bearer $token',
        });

        if (response.statusCode == 200) {
          List<dynamic> searchData = jsonDecode(response.body);
          recentSearches.assignAll(searchData.map((data) => data.toString()));
        } else {
          throw Exception('Failed to load recent searches');
        }
      } else {
        throw Exception('Token not found in SharedPreferences');
      }
    } catch (error) {
      print('Error fetching recent searches: $error');
      // Handle error gracefully
    } finally {
      isLoading.value = false;
    }
  }

  void removeRecentSearch(int index) {
    recentSearches.removeAt(index);
  }
}
