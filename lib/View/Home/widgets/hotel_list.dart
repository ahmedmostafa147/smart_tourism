import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_tourism/Model/hotel.dart';
import 'package:smart_tourism/View/Home/widgets/custom_list_title.dart';

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
          height: 200.h, // Adjust based on the height of each CustomListTile
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: hotels.length,
            itemBuilder: (context, index) {
              final hotel = hotels[index];
              return CustomListTile(
                title: hotel.hotelName,
                subtitle: 'Governorate: ${hotel.governorate} | Country: ${hotel.hotelLoc}',
                imageURL: hotel.hotelImage,
                price: '${hotel.price}',
                rating: hotel.rate,
              );
            },
          ),
        ),
      ],
    );
  }
}
