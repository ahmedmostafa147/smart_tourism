import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_tourism/Controller/Get_Home/master_controller.dart';
import 'package:smart_tourism/View/Auth/AuthWidget/text_form_field.dart';
import 'package:smart_tourism/View/Home/widgets/custom_list_title.dart';
import 'package:smart_tourism/View/Search/result_search.dart';
import '../Home/widgets/shammer.dart';

class HomeSearchScreen extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Home'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Get.to(() => ResultSearch());
              },
              child: Container(
                height: 50.h,
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Row(
                  children: [
                    Icon(Icons.search, color: Colors.grey),
                    SizedBox(width: 8.0),
                    Text(
                      'Search for places...',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return ListView.builder(
                    itemCount: 3,
                    itemBuilder: (context, index) => ShimmerListTile(),
                  );
                } else {
                  return ListView(
                    children: [
                      if (controller.randomHotels.isNotEmpty) ...[
                        HotelListView(hotels: controller.randomHotels),
                      ],
                      if (controller.randomRestaurants.isNotEmpty) ...[
                        RestaurantListView(
                          restaurants: controller.randomRestaurants,
                        ),
                      ],
                      if (controller.randomPlaces.isNotEmpty) ...[
                        PlaceListView(places: controller.randomPlaces),
                      ],
                    ],
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
