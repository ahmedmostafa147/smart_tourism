import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_tourism/Model/restaurant.dart';
import 'package:smart_tourism/View/Home/widgets/custom_list_title.dart';

class RestaurantListView extends StatelessWidget {
  final List<Restaurant> restaurants;

  const RestaurantListView({Key? key, required this.restaurants})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'You may like these Restaurants'.tr,
          style: TextStyle(
            color: Colors.teal,
            fontSize: 20.sp,
            height: 1.3.sp,
          ),
        ),
        SizedBox(height: 10.h),
        SizedBox(
          height: 200.h, // Adjust based on the height of each CustomListTile
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: restaurants.length,
            itemBuilder: (context, index) {
              final restaurant = restaurants[index];
              return CustomListTile(
                title: restaurant.restaurantName,
                subtitle:
                    'Governorate: ${restaurant.governorate} | Country: ${restaurant.restaurantLoc}',
                imageURL: restaurant.restaurantImage,
                price: '${restaurant.price}',
                rating: restaurant.rate,
              );
            },
          ),
        ),
      ],
    );
  }
}
