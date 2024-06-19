import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../Core/End%20Points/endpoints.dart';

class SearchParameters {
  String? country;
  String? governorate;
  String? category;
  String? name;

  SearchParameters({this.country, this.governorate, this.category, this.name});

  factory SearchParameters.fromJson(Map<String, dynamic> json) {
    return SearchParameters(
      country: json['country'] as String?,
      governorate: json['governorate'] as String?,
      category: json['category'] as String?,
      name: json['name'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'country': country,
      'governorate': governorate,
      'category': category,
      'name': name,
    };
  }
}

// Assuming SearchResult class exists as previously defined
class SearchResult {
  final String type;
  final String name;
  final int price;
  final String governorate;
  final String country;
  final String image;
  final double rate;

  SearchResult({
    required this.type,
    required this.name,
    required this.price,
    required this.governorate,
    required this.country,
    required this.image,
    required this.rate,
  });

  factory SearchResult.fromJson(Map<String, dynamic> json) {
    return SearchResult(
      type: json['type'] ?? '',
      name: json['name'] ?? '',
      price: json['price'] ?? 0,
      governorate: json['governorate'] ?? '',
      country: json['country'] ?? '',
      image: json['image'] ?? '',
      rate: (json['rate'] ?? 0.0).toDouble(),
    );
  }
}


class SearchControllerOne extends GetxController {
  TextEditingController searchController = TextEditingController();
  RxList<SearchResult> searchResults = <SearchResult>[].obs;
  RxList<String> recentSearches = <String>[].obs;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadRecentSearches();
  }

  Future<void> loadRecentSearches() async {
    final SharedPreferences prefs = await _prefs;
    recentSearches.value = prefs.getStringList('recentSearches') ?? [];
  }

  Future<void> saveRecentSearch(String search) async {
    final SharedPreferences prefs = await _prefs;
    if (!recentSearches.contains(search)) {
      recentSearches.add(search);
      await prefs.setStringList('recentSearches', recentSearches);
    }
  }

  Future<void> search(SearchParameters params) async {
  var headers = {'Content-Type': 'application/json'};
  try {
    final SharedPreferences prefs = await _prefs;
    final String? token = prefs.getString('token');

    if (token == null) {
      throw 'User is not authenticated';
    }

    headers['Authorization'] = 'Bearer $token';

    var url = Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.search);
    http.Response response = await http.post(
      url,
      body: jsonEncode(params.toJson()),
      headers: headers,
    );

    if (response.statusCode == 200) {
      dynamic jsonResponse = jsonDecode(response.body);
      if (jsonResponse is Map<String, dynamic> && jsonResponse['results'] is List) {
        searchResults.value = (jsonResponse['results'] as List)
            .map((data) => SearchResult.fromJson(data))
            .toList();
      } else {
        throw 'Unexpected response format';
      }
      saveRecentSearch(jsonEncode(params.toJson()));
    } else if (response.statusCode == 401) {
      Get.snackbar("Error", "Unauthorized: Please login again",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
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
  }
}

  Future<void> clearRecentSearches() async {
    final SharedPreferences prefs = await _prefs;
    recentSearches.clear();
    await prefs.remove('recentSearches');
  }

  void removeRecentSearch(String search) async {
    final SharedPreferences prefs = await _prefs;
    recentSearches.remove(search);
    await prefs.setStringList('recentSearches', recentSearches);
  }
}
