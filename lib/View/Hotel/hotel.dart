import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_tourism/Controller/Get_Home/hotel_controller.dart';

class RandomHotelsScreen extends StatelessWidget {
  final HotelController hotelController = Get.put(HotelController());
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
            hotelController.fetchRandomHotels(country);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              hotelController.fetchRandomHotels(countryController.text);
            },
          ),
        ],
      ),
      body: Obx(() {
        if (hotelController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (hotelController.randomHotels.isEmpty) {
          return Center(child: Text('No hotels found'));
        } else {
          return ListView.builder(
            itemCount: hotelController.randomHotels.length,
            itemBuilder: (context, index) {
              final hotel = hotelController.randomHotels[index];
              return Card(
                elevation: 2.0,
                margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.network(
                      hotel.hotelImage,
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
                            hotel.hotelName,
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
                              Text('${hotel.governorate}, ${hotel.hotelLoc}'),
                            ],
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            'Price: ${hotel.price} \$',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.blue,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            'Rating: ${hotel.rate.toStringAsFixed(2)}',
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
