import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_tourism/Controller/Get_Home/hotel_controller.dart';
import 'package:smart_tourism/Controller/Get_Home/place_controller.dart';
import 'package:smart_tourism/Controller/Get_Home/restaurant_controller.dart';
import 'widgets/app_bar_home.dart';
import 'widgets/container_center_home_screen.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HotelController _hotelController = Get.put(HotelController());
  final RestaurantController _restaurantController =
      Get.put(RestaurantController());
  final PlaceController _placeController = Get.put(PlaceController());

  @override
  void initState() {
    super.initState();
    _hotelController
        .fetchRandomHotelsHome(); // استرجاع الفنادق المختارة عند بدء تشغيل الصفحة
    _restaurantController
        .fetchRandomRestaurantsHome(); // استرجاع المطاعم المختارة عند بدء تشغيل الصفحة
    _placeController
        .fetchRandomPlacesHome(); // استرجاع الأماكن المختارة عند بدء تشغيل الصفحة
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarHome(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Discover'.tr,
                style: TextStyle(
                  color: Colors.teal,
                  fontSize: 32.sp,
                  height: 1.3.sp,
                  fontFamily: "Mano",
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              ContainerOPtionsSearch(),
              SizedBox(
                height: 24.h,
              ),
              Obx(() {
                if (_hotelController.isLoading.value ||
                    _restaurantController.isLoading.value ||
                    _placeController.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (_hotelController.randomHotels.isNotEmpty) ...[
                        Text(
                          'You may like these Hotels'.tr,
                          style: TextStyle(
                            color: Colors.teal,
                            fontSize: 20.sp,
                            height: 1.3.sp,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: _hotelController.randomHotels.length,
                          itemBuilder: (context, index) {
                            final hotel = _hotelController.randomHotels[index];
                            return ListTile(
                              title: Text(hotel.hotelName),
                              subtitle: Text(
                                'Governorate: ${hotel.governorate}, Country: ${hotel.governorate}',
                              ),
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                  hotel.hotelImage,
                                ),
                              ),
                              trailing: Text('${hotel.price}'),
                            );
                          },
                        ),
                        SizedBox(height: 15.h),
                      ],
                      // عرض المطاعم
                      if (_restaurantController
                          .randomRestaurants.isNotEmpty) ...[
                        Text(
                          'You may like these Restaurants'.tr,
                          style: TextStyle(
                            color: Colors.teal,
                            fontSize: 20.sp,
                            height: 1.3.sp,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount:
                              _restaurantController.randomRestaurants.length,
                          itemBuilder: (context, index) {
                            final restaurant =
                                _restaurantController.randomRestaurants[index];
                            return ListTile(
                              title: Text(restaurant.restaurantName),
                              subtitle: Text(
                                'Category: ${restaurant.governorate}, Country: ${restaurant.governorate}',
                              ),
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                  restaurant.restaurantImage,
                                ),
                              ),
                              trailing: Text('${restaurant.price}'),
                            );
                          },
                        ),
                        SizedBox(height: 15.h),
                      ],
                      // عرض الأماكن
                      if (_placeController.randomPlaces.isNotEmpty) ...[
                        Text(
                          'You may like these Places'.tr,
                          style: TextStyle(
                            color: Colors.teal,
                            fontSize: 20.sp,
                            height: 1.3.sp,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: _placeController.randomPlaces.length,
                          itemBuilder: (context, index) {
                            final place = _placeController.randomPlaces[index];
                            return ListTile(
                              title: Text(place.placeName),
                              subtitle: Text(
                                'Governorate: ${place.governorate}, Location: ${place.placeLoc}',
                              ),
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                  place.placeImage,
                                ),
                              ),
                              trailing: Text('${place.price}'),
                            );
                          },
                        ),
                        SizedBox(height: 15.h),
                      ],
                    ],
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
