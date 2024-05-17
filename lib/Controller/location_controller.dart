import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationController extends GetxController {
  var address = 'Location'.obs;
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;
  var isLoading = false.obs;
  var addressCountry = "Location".obs;

  @override
  void onInit() {
    super.onInit();
    _getLocationFromPreferences();
  }

  Future<void> getCurrentLocation() async {
    try {
      isLoading.value = true;
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        address.value = 'Permission denied';
        return Future.error('Location permissions are denied');
      } else if (permission == LocationPermission.deniedForever) {
        address.value = 'Permission denied';
        return Future.error('Location permissions are permanently denied');
      }

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      Placemark place = placemarks.first;
      address.value = "${place.locality} ${place.country}";
      addressCountry.value = "${place.country}";
      latitude.value = position.latitude;
      longitude.value = position.longitude;

      _saveLocationData(address.value, addressCountry.value, position.latitude,
          position.longitude);
      Get.snackbar("Success", "Location has been set successfully",
          backgroundColor: Get.theme.primaryColor,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar("Error", e.toString(),
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);

      address.value = 'Error getting location';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _saveLocationData(String address, String addressCountry,
      double latitude, double longitude) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('address', address);
    prefs.setString('addressCountry', addressCountry);
    prefs.setDouble('latitude', latitude);
    prefs.setDouble('longitude', longitude);
  }

  Future<void> _getLocationFromPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String savedAddress = prefs.getString('address') ?? 'Location';
    String savedAddressCountry =
        prefs.getString('addressCountry') ?? 'Location';
    double savedLatitude = prefs.getDouble('latitude') ?? 0.0;
    double savedLongitude = prefs.getDouble('longitude') ?? 0.0;

    address.value = savedAddress;
    addressCountry.value = savedAddressCountry;
    latitude.value = savedLatitude;
    longitude.value = savedLongitude;
  }
}
