import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:smart_tourism/Core/End%20Points/endpoints.dart';

class Favorite {
  final int id;
  final String type;
  final String name;
  final String location;

  Favorite(
      {required this.id,
      required this.type,
      required this.name,
      required this.location});

  factory Favorite.fromJson(Map<String, dynamic> json) {
    return Favorite(
      id: json['id'],
      type: json['type'],
      name: json['name'],
      location: json['location'],
    );
  }
}

class FavoriteController extends GetxController {
  var favorites = <Favorite>[].obs;

  Future<void> createFavorite(String type, String name, String location) async {
    final url = ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.favorites;
    final body = jsonEncode({
      "type": type,
      "name": name,
      "location": location,
    });

    final response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: body,
    );

    if (response.statusCode == 200) {
      Get.snackbar("Success", "Favorite added successfully");
      fetchFavorites();
    } else {
      Get.snackbar("Error", "Failed to add favorite");
    }
  }

  Future<void> fetchFavorites() async {
    final url = ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.favorites;
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      favorites.value = data.map((item) => Favorite.fromJson(item)).toList();
    } else {
      Get.snackbar("Error", "Failed to fetch favorites");
    }
  }

  Future<void> deleteFavorite(int id) async {
    final url =
        '${ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.favorites}$id';
    final response = await http.delete(Uri.parse(url));

    if (response.statusCode == 200) {
      Get.snackbar("Success", "Favorite deleted successfully");
      fetchFavorites();
    } else {
      Get.snackbar("Error", "Failed to delete favorite");
    }
  }
}
