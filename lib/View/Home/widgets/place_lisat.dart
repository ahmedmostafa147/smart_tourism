import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_tourism/Model/place.dart';
import 'package:smart_tourism/View/Home/widgets/custom_list_title.dart';

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
          height: 200.h, // Adjust based on the height of each CustomListTile
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: places.length,
            itemBuilder: (context, index) {
              final place = places[index];
              return CustomListTile(
                title: place.placeName,
                subtitle: 'Governorate: ${place.governorate} | Country: ${place.placeLoc}',
                imageURL: place.placeImage,
                price: '${place.price}',
                rating: place.rate,
              );
            },
          ),
        ),
      ],
    );
  }
}
