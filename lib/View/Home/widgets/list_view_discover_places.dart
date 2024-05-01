import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../Core/constants/images.dart';

class ListDiscoverPlaces extends StatelessWidget {
  const ListDiscoverPlaces({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Discover Places'.tr,
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'View All'.tr,
              style: TextStyle(fontSize: 17.sp, color: Colors.teal),
            ),
          ],
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 3,
          itemBuilder: (BuildContext context, int index) {
            List<String> imagePaths = [
              Assets.imagesImg1,
              Assets.imagesImg2,
              Assets.imagesImg3,
            ];

            List<String> titles = [
              "Magic Tower",
              "Dubai Burg",
              "Mall of the Emirates",
            ];

            List<String> distances = [
              "1 km away",
              "2 km away",
              "3 km away",
            ];

            List<String> ratings = [
              "4.5",
              "3.8",
              "4.2",
            ];

            return Padding(
              padding: EdgeInsets.only(bottom: 15.0),
              child: GestureDetector(
                onTap: () {},
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
                            style: TextStyle(
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
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Color(0xff686771),
                                ),
                              ),
                              Spacer(),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: ImageIcon(
                                      AssetImage(
                                        Assets.imagesMenu,
                                      ),
                                      size: 20.r,
                                      color: Colors.black,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: ImageIcon(
                                      AssetImage(
                                        Assets.imagesMenu,
                                      ),
                                      size: 20.r,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  ImageIcon(
                                    AssetImage(
                                      Assets.imagesMenu,
                                    ),
                                    size: 15.r,
                                    color: Colors.teal,
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Text(
                                    ratings[
                                        index], // Use the rating from the list
                                    style: TextStyle(
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
      ],
    );
  }
}
