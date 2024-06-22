import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_tourism/Controller/Get_Home/place_controller.dart';

class RandomPlacesScreen extends StatelessWidget {
  final PlaceController placeController = Get.put(PlaceController());
  final TextEditingController countryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: countryController,
          decoration: InputDecoration(
            hintText: 'Enter country...',
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.white60),
          ),
          style: TextStyle(color: Colors.white),
          onSubmitted: (country) {
            placeController.fetchRandomPlaces(country);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              placeController.fetchRandomPlaces(countryController.text);
            },
          ),
        ],
      ),
      body: Obx(() {
        if (placeController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (placeController.randomPlaces.isEmpty) {
          return Center(child: Text('No places found'));
        } else {
          return ListView.builder(
            itemCount: placeController.randomPlaces.length,
            itemBuilder: (context, index) {
              final place = placeController.randomPlaces[index];
              return Card(
                elevation: 2.0,
                margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.network(
                      place.placeImage,
                      height: 200.h,
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
                            place.placeName,
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Row(
                            children: [
                              Icon(Icons.location_on,
                                  size: 16.0, color: Colors.grey),
                              SizedBox(width: 4.0),
                              Text(' ${place.placeLoc}'),
                            ],
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            'Price: ${place.price} \$',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.blue,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            'Rating: ${place.rate.toStringAsFixed(2)}',
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
