import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_tourism/Controller/favorite/favorite_controller.dart';
import 'package:smart_tourism/Model/hotel.dart';
import 'package:smart_tourism/Model/place.dart';
import 'package:smart_tourism/Model/restaurant.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageURL;
  final String price;
  final double rating;

  CustomListTile({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.imageURL,
    required this.price,
    required this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FavoriteController favoriteController = Get.put(FavoriteController());

    return Card(
      clipBehavior: Clip.antiAlias,
      color: Colors.transparent,
      margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            clipBehavior: Clip.antiAlias,
            fit: StackFit.loose,
            children: [
              Container(
                alignment: Alignment.center,
                height: 100.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(10.0)),
                ),
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(10.0)),
                  child: CachedNetworkImage(
                    imageUrl: imageURL,
                    fit: BoxFit.fill,
                    width: double.infinity,
                    height: 100.h,
                    placeholder: (context, url) =>
                        Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        Icon(Icons.broken_image, size: 100.r),
                  ),
                ),
              ),
              Obx(() {
                bool isFavorite = favoriteController.isFavorite(title);
                return IconButton(
                  onPressed: () async {
                    if (isFavorite) {
                      await favoriteController.deleteFavoriteByName(title);
                    } else {
                      await favoriteController.createFavorite(
                          'Hotel', title, subtitle);
                    }
                  },
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_outline,
                    color: isFavorite ? Colors.green : Colors.white,
                  ),
                );
              }),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                    fontFamily: "Mano",
                    height: 1.sp,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 8.0),
                Row(
                  children: [
                    Icon(Icons.location_on, size: 10.0.r, color: Colors.grey),
                    SizedBox(width: 4.0),
                    Text(subtitle,
                        style: TextStyle(
                          fontSize: 10.0.sp,
                          color: Colors.grey,
                          fontWeight: FontWeight.w600,
                          overflow: TextOverflow.ellipsis,
                        )),
                  ],
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Price: $price \$',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.teal,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8.0),
                Row(
                  children: [
                    Icon(Icons.star, size: 16.r, color: Colors.orange),
                    SizedBox(width: 4.0),
                    Text(
                      'Rating: ${rating.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 12.0.sp,
                        color: Colors.orange,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HotelListView extends StatelessWidget {
  final List<Hotel> hotels;

  const HotelListView({Key? key, required this.hotels}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'You may like these Hotels'.tr,
          style: TextStyle(
            color: Colors.teal,
            fontSize: 20.sp,
            height: 1.3.sp,
          ),
        ),
        SizedBox(height: 10.h),
        SizedBox(
          height: 250.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: hotels.length,
            itemBuilder: (context, index) {
              final hotel = hotels[index];
              return Container(
                width: 200.w,
                child: CustomListTile(
                  title: hotel.hotelName,
                  subtitle: ' ${hotel.governorate} | ${hotel.hotelLoc}',
                  imageURL: hotel.hotelImage,
                  price: '${hotel.price}',
                  rating: hotel.rate,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

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
          height: 250.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: restaurants.length,
            itemBuilder: (context, index) {
              final restaurant = restaurants[index];
              return Container(
                width: 200.w, // Ensure a fixed width for each item
                child: CustomListTile(
                  title: restaurant.restaurantName,
                  subtitle:
                      ' ${restaurant.governorate} | ${restaurant.restaurantLoc}',
                  imageURL: restaurant.restaurantImage,
                  price: '${restaurant.price}',
                  rating: restaurant.rate,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class PlaceListView extends StatelessWidget {
  final List<Place> places;

  const PlaceListView({Key? key, required this.places}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'You may like these Places'.tr,
          style: TextStyle(
            color: Colors.teal,
            fontSize: 20.sp,
            height: 1.3.sp,
          ),
        ),
        SizedBox(height: 10.h),
        SizedBox(
          height: 250.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: places.length,
            itemBuilder: (context, index) {
              final place = places[index];
              return Container(
                width: 200.w, // Ensure a fixed width for each item
                child: CustomListTile(
                  title: place.placeName,
                  subtitle: '${place.placeLoc} | ${place.placeLoc}',
                  imageURL: place.placeImage,
                  price: '${place.price}',
                  rating: place.rate,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
