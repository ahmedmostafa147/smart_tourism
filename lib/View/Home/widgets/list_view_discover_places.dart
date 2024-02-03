import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smart_tourism/View/Home/widgets/det.dart';
import 'package:smart_tourism/constants/ImagesForFullApp.dart';
import 'package:smart_tourism/data/Models/1.dart';

class ListDiscoverPlaces extends StatelessWidget {
  const ListDiscoverPlaces({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16),
     height: 400.h,
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          List<String> imagePaths = [
            Assets.imagesImg1,
            Assets.imagesImg2,
            Assets.imagesImg3,
            Assets.imagesImg4,
            Assets.imagesImg5,

          ];

          List<String> titles = [
            "Title 1",
            "Title 2",
            "Title 3",
            "Title 4",
            "Title 5",
          ];

          List<String> distances = [
            "1 km away",
            "2 km away",
            "3 km away",
            "4 km away",
            "5 km away",
          ];

          List<String> ratings = [
            "4.5",
            "3.8",
            "4.2",
            "5.0",
            "4.1",
          ];

          return Padding(
            padding: EdgeInsets.only(bottom: 15.0),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => DetailView(id: index)));
              },
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                    child: Image.asset(
                      imagePaths[index], // Use the image path from the list
                      fit: BoxFit.fill,
                      height: 60.0.h,
                      width: 60.0.w,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          titles[index], // Use the title from the list
                          style:  TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                         SizedBox(
                          height: 8.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              distances[
                                  index], // Use the distance from the list
                              style:  TextStyle(
                                fontSize: 12.sp,
                                color: Color(0xff686771),
                              ),
                            ),
                            Spacer(),
                            Row(
                              
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  FontAwesomeIcons.plusCircle,
                                  color: Colors.teal,
                                  size: 25.r,
                                ),
                                 SizedBox(
                                  width: 5.w,
                                ),
                                 Icon(
                                  FontAwesomeIcons.heart,
                                  color: Colors.teal,
                                  size: 25.r,
                                ),
                                 SizedBox(
                                  width: 5.w,
                                ),
                                Text(
                                  ratings[
                                      index], // Use the rating from the list
                                  style:  TextStyle(
                                    fontSize: 15.sp,
                                  ),
                                ),

                                
                              ],
                            ),
                          ],
                        ),
                        Divider(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
