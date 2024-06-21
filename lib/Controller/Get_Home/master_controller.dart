import 'package:get/get.dart';
import 'package:smart_tourism/Controller/Get_Home/hotel_controller.dart';
import 'package:smart_tourism/Controller/Get_Home/place_controller.dart';
import 'package:smart_tourism/Controller/Get_Home/restaurant_controller.dart';
import 'package:smart_tourism/Model/hotel.dart';
import 'package:smart_tourism/Model/place.dart';
import 'package:smart_tourism/Model/restaurant.dart';

class HomeController extends GetxController {
  final HotelController hotelController = Get.put(HotelController());
  final RestaurantController restaurantController = Get.put(RestaurantController());
  final PlaceController placeController = Get.put(PlaceController());

  var isLoading = true.obs;

  List<Hotel> get randomHotels => hotelController.randomHotels;
  List<Restaurant> get randomRestaurants => restaurantController.randomRestaurants;
  List<Place> get randomPlaces => placeController.randomPlaces;

  @override
  void onInit() {
    super.onInit();
    fetchInitialData();
  }

  void fetchInitialData() async {
    await hotelController.fetchRandomHotelsHome();
    await restaurantController.fetchRandomRestaurantsHome();
    await placeController.fetchRandomPlacesHome();
    isLoading.value = false;
  }
}
