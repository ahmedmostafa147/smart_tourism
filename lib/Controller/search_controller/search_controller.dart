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

  SearchParameters({
    this.country,
    this.governorate,
    this.category,
    this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'country': country ?? '',
      'governorate': governorate ?? '',
      'category': category ?? '',
      'name': name ?? '',
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'country': country ?? '',
      'governorate': governorate ?? '',
      'category': category ?? '',
      'name': name ?? '',
    };
  }
}

class SearchResult {
  final String type;
  final String name;
  final int price;
  final String governorate;
  final String country;
  final String image;
  final double rate;
  final String comment;

  SearchResult({
    required this.type,
    required this.name,
    required this.price,
    required this.governorate,
    required this.country,
    required this.image,
    required this.rate,
    required this.comment,
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
      comment: json['comment'] ?? '',
    );
  }
}

class SearchControllerOne extends GetxController {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  var isLoading = false.obs;
  var searchController = TextEditingController();
  var searchResults = <SearchResult>[].obs;

  var recentSearches = <SearchResult>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadRecentSearches();
  }

  Future<void> loadRecentSearches() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final String? token = prefs.getString('token');
      if (token == null) {
        throw 'User is not authenticated';
      }

      final response = await http.get(
        Uri.parse(
            ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.recentSearches),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List<SearchResult> recentSearchesList =
            (data['recent_searches'] as List)
                .map((item) => SearchResult.fromJson(item))
                .toList();
        recentSearches.assignAll(recentSearchesList);
      } else {
        throw Exception('Failed to load recent searches');
      }
    } catch (e) {
      if (e is Exception) {
        print(e.toString());
      }
    }
  }

  Future<void> search(SearchParameters params) async {
    var headers = {'Content-Type': 'application/json'};
    try {
      isLoading.value = true;
      final SharedPreferences prefs = await _prefs;
      final String? token = prefs.getString('token');

      if (token == null) {
        throw 'User is not authenticated';
      }

      headers['Authorization'] = 'Bearer $token';

      var url =
          Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.search);

      // طباعة البيانات المرسلة للتحقق منها
      print("Request URL: $url");
      print("Request Headers: $headers");
      print("Request Body: ${jsonEncode(params.toJson())}");

      http.Response response = await http.post(
        url,
        body: jsonEncode(params.toJson()),
        headers: headers,
      );

      // طباعة حالة الاستجابة والبيانات المستلمة
      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        isLoading.value = false;
        var jsonResponse = jsonDecode(response.body);

        print("Response JSON: $jsonResponse");
        if (jsonResponse is Map<String, dynamic> &&
            jsonResponse['results'] is List) {
          searchResults.value = (jsonResponse['results'] as List)
              .map((data) => SearchResult.fromJson(data))
              .toList();
        } else {
          // التعامل مع حالة عدم وجود نتائج
          searchResults.clear();
          Get.snackbar("Info", "No matching results found",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.blue,
              colorText: Colors.white);
        }
      } else if (response.statusCode == 401) {
        isLoading.value = false;
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
}
