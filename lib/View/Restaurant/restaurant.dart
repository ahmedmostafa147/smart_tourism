import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_tourism/Controller/Get_Home/restaurant_controller.dart';

class RandomRestaurantsScreen extends StatelessWidget {
  final RestaurantController restaurantController = Get.put(RestaurantController());
  final TextEditingController countryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: countryController,
          decoration: InputDecoration(
            hintText: 'Search...',
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.white60),
          ),
          style: TextStyle(color: Colors.white),
          onSubmitted: (country) {
            restaurantController.fetchRandomRestaurants(country);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              restaurantController.fetchRandomRestaurants(countryController.text);
            },
          ),
        ],
      ),
      body: Obx(() {
        if (restaurantController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (restaurantController.randomRestaurants.isEmpty) {
          return Center(child: Text('No restaurants found'));
        } else {
          return ListView.builder(
            itemCount: restaurantController.randomRestaurants.length,
            itemBuilder: (context, index) {
              final restaurant = restaurantController.randomRestaurants[index];
              return Card(
                elevation: 2.0,
                margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.network(
                      restaurant.restaurantImage,
                      height: 200,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(Icons.broken_image, size: 200);
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            restaurant.restaurantName,
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Row(
                            children: [
                              Icon(Icons.location_on, size: 16.0, color: Colors.grey),
                              SizedBox(width: 4.0),
                              Text('${restaurant.governorate}, ${restaurant.restaurantLoc}'),
                            ],
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            'Price: ${restaurant.price} \$',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.blue,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            'Rating: ${restaurant.rate.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.orange,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
      }),
    );
  }
}
