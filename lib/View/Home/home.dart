import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'widgets/you_may_like_this.dart';
import 'widgets/app_bar_home.dart';
import 'widgets/container_center_home_screen.dart';
import 'widgets/container_display_nearest.dart';
import 'widgets/last_plan_home.dart';
import 'widgets/list_view_discover_places.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarHome(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Discover'.tr,
                style: TextStyle(
                    color: Colors.teal,
                    fontSize: 32.sp,
                    height: 1.3.sp,
                    fontFamily: "Mano"),
              ),
              SizedBox(
                height: 15.h,
              ),
              ContainerOPtionsSearch(),
              SizedBox(
                height: 24.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Nearest to you'.tr,
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
              // ContainerDisplayNearestHome(),
              SizedBox(
                height: 24.h,
              ),
              LastPlan(),
              SizedBox(
                height: 24.h,
              ),
              ListDiscoverPlaces(),
              SizedBox(
                height: 24.h,
              ),
              YouMayLikeThis(),
              SizedBox(
                height: 24.h,
              ),
              ContainerDisplayRes(),
              SizedBox(
                height: 24.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
