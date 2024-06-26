import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_tourism/Controller/Get_Home/master_controller.dart';
import 'package:smart_tourism/View/Home/widgets/custom_list_title.dart';
import 'package:smart_tourism/View/Home/widgets/may_like.dart';
import 'package:smart_tourism/View/Home/widgets/shammer.dart';
import 'widgets/app_bar_home.dart';
import 'widgets/container_center_home_screen.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());
    return Scaffold(
      appBar: CustomAppBarHome(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.blueGrey[900],
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(30.h)),
              ),
              clipBehavior: Clip.antiAlias,
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Discover'.tr,
                    style: TextStyle(
                      color: Colors.teal,
                      fontSize: 32.sp,
                      height: 1.3.sp,
                      fontFamily: "Mano",
                    ),
                  ),
                  SizedBox(height: 15.h),
                  ContainerOPtionsSearch(),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
            SizedBox(height: 15.h),
            Obx(() {
              if (controller.isLoading.value) {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 3,
                  itemBuilder: (context, index) => ShimmerListTile(),
                );
              } else {
                return Column(
                  children: [
                    if (controller.randomHotels.isNotEmpty) ...[
                      HotelListView(hotels: controller.randomHotels),
                      SizedBox(height: 15.h),
                    ],
                    if (controller.randomRestaurants.isNotEmpty) ...[
                      RestaurantListView(
                          restaurants: controller.randomRestaurants),
                      SizedBox(height: 15.h),
                    ],
                    if (controller.randomPlaces.isNotEmpty) ...[
                      PlaceListView(places: controller.randomPlaces),
                      SizedBox(height: 15.h),
                    ],
                  ],
                );
              }
            }),
            MayLikedListView(),
          ],
        ),
      ),
    );
  }
}
