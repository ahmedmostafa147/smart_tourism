import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../Core/End%20Points/endpoints.dart';

class Favorite {
  final int id;
  final String type;
  final String name;
  final String location;

  Favorite({
    required this.id,
    required this.type,
    required this.name,
    required this.location,
  });

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

  Future<void> createFavorite(String type, String name, String location,
      int place_id, int hotel_id, int rest_id) async {
    final url = ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.favorites;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    if (token == null) {
      Get.snackbar("Error", "User is not logged in");
      return;
    }
    final body = jsonEncode({
      "type": type,
      "name": name,
      "location": location,
      "place_id": place_id,
      "hotel_id": hotel_id,
      "rest_id": rest_id
    });

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: body,
      );

      if (response.statusCode == 200) {
        Get.snackbar("Success", "Favorite added successfully");
      } else {
        print('Failed to add favorite. Response code: ${response.statusCode}');
        print(response.body);
        Get.snackbar("Error", "Failed to add favorite");
      }
    } catch (e) {
      print('Error adding favorite: $e');
      Get.snackbar("Error", "An error occurred while adding favorite");
    }
  }

  Future<void> fetchFavorites() async {
    final url = ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.favorites;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    if (token == null) {
      Get.snackbar("Error", "User is not logged in");
      return;
    }

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        favorites.value = data.map((item) => Favorite.fromJson(item)).toList();
      } else {
        print(
            'Failed to fetch favorites. Response code: ${response.statusCode}');
        Get.snackbar("Error", "Failed to fetch favorites");
      }
    } catch (e) {
      print('Error fetching favorites: $e');
      Get.snackbar("Error", "An error occurred while fetching favorites");
    }
  }

  Future<void> deleteFavorite(int id) async {
    final url =
        '${ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.favorites}$id';
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    if (token == null) {
      Get.snackbar("Error", "User is not logged in");
      return;
    }

    try {
      final response = await http.delete(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        Get.snackbar("Success", "Favorite deleted successfully");
        await fetchFavorites();
      } else {
        print(
            'Failed to delete favorite. Response code: ${response.statusCode}');
        Get.snackbar("Error", "Failed to delete favorite");
      }
    } catch (e) {
      print('Error deleting favorite: $e');
      Get.snackbar("Error", "An error occurred while deleting favorite");
    }
  }

  bool isFavorite(String name) {
    return favorites.any((favorite) => favorite.name == name);
  }

  Future<void> deleteFavoriteByName(String name) async {
    final index = favorites.indexWhere((favorite) => favorite.name == name);
    if (index != -1) {
      final favorite = favorites[index];
      await deleteFavorite(favorite.id);
      favorites.removeAt(index);
    }
  }
}
